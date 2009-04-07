From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git config' access
Date: Tue, 07 Apr 2009 05:01:37 -0700 (PDT)
Message-ID: <m3prfo1xh6.fsf@localhost.localdomain>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
	<20090406092942.GW17706@mail-vs.djpig.de>
	<1239058276.31863.19.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Apr 07 14:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrA2G-0002aW-KA
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 14:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbZDGMBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 08:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbZDGMBn
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 08:01:43 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:26224 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755AbZDGMBk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 08:01:40 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2732378wff.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=nanA9CCOvdjsqj15+IcN70b4JhbhCPNDiGgPbsUU/1o=;
        b=SZt5F6ftqNelWhMAi1DxxkHTgG4T1I42lQfBWF4PKa4BIroI1Lv3IXr5IXpoyIswp4
         rY/Xb8ZYklaKleYdFO3Qw9Yy6iHIZ5LRwqgywjBQeX5BL2vUTDVmZbZ/ENiXtabntuVd
         MoHaLhbOh9VaPU+sjvqVhq4k1iHigbQSJhGnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LEvPn3HohZ7pdaeG8PFtFWP6P657vybOYw7OSabhy9Z5uvzLxZKItng/P6pyuDN3lW
         VWcxpYIev3Ddq+TlkZWdSotLrv+OdoOeZQVz3V92DQOAXwi/tDtU9MujS8U2hFEygD4J
         Xqi8V6YmOaG8TWmyKO9p1udV1TxkuBwUBJNVI=
Received: by 10.142.177.5 with SMTP id z5mr15607wfe.89.1239105698847;
        Tue, 07 Apr 2009 05:01:38 -0700 (PDT)
Received: from localhost.localdomain (abvx71.neoplus.adsl.tpnet.pl [83.8.221.71])
        by mx.google.com with ESMTPS id 22sm6822657wfd.26.2009.04.07.05.01.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 05:01:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n37C4RGS020775;
	Tue, 7 Apr 2009 14:04:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n37C4MdB020766;
	Tue, 7 Apr 2009 14:04:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1239058276.31863.19.camel@maia.lan>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115949>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> On Mon, 2009-04-06 at 11:29 +0200, Frank Lichtenheld wrote:
> > On Mon, Apr 06, 2009 at 11:46:15AM +1200, Sam Vilain wrote:

> > > +	my ($fh, $c) = $git->command_output_pipe(
> > > +		'config', ( $which ? ("--$which") : () ),
> > > +		'--list',
> > > +	       );
> >
> > Any reason why you don't use --null here? The output of --list
> > without --null is not reliably parsable, since people can put
> > newlines in values.
> 
> No particularly good reason :-)
> 
> Subject: [PATCH] perl: make Git::Config use --null
> 
> Use the form of 'git-config' designed for parsing by modules like
> this for safety with values containing embedded line feeds.
> 
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>

> diff --git a/perl/Git/Config.pm b/perl/Git/Config.pm
> index a0a6a41..a35d9f3 100644
> --- a/perl/Git/Config.pm
> +++ b/perl/Git/Config.pm
> @@ -179,12 +179,14 @@ sub read {
>  
>  	my ($fh, $c) = $git->command_output_pipe(
>  		'config', ( $which ? ("--$which") : () ),
> -		'--list',
> +		 '--null', '--list',
>  	       );
>  	my $read_state = {};
>  
> +	local($/)="\0";
>  	while (<$fh>) {
> -		my ($item, $value) = m{(.*?)=(.*)};
> +		my ($item, $value) = m{(.*?)\n((?s:.*))\0}
> +			or die "failed to parse it; \$_='$_'";
>  		my $sl = \( $read_state->{$item} );
>  		if (!defined $$sl) {
>  			$$sl = $value;

Errr... wouldn't it be better to simply use 

+		my ($item, $value) = split("\n", $_, 2)

here? Have you tested Git::Config with a "null" value, i.e. something
like

    [section]
        noval

in the config file (which evaluates to 'true' with '--bool' option)?
Because from what I remember from the discussion on the 
"git config --null --list" format the lack of "\n" is used to
distinguish between noval (which is equivalent to 'true'), and empty
value (which is equivalent to 'false')

    [boolean
        noval        # equivalent to 'true'
        empty1 =     # equivalent to 'false'
        empty2 = ""  # equivalent to 'false'

> diff --git a/t/t9700/config.t b/t/t9700/config.t
> index 395a5c9..f0f7d2d 100644
> --- a/t/t9700/config.t
> +++ b/t/t9700/config.t
> @@ -16,6 +16,7 @@ in_empty_repo sub {
>  	$git->command_oneline("config", "foo.intval", "12g");
>  	$git->command_oneline("config", "foo.false.val", "false");
>  	$git->command_oneline("config", "foo.true.val", "yes");
> +	$git->command_oneline("config", "multiline.val", "hello\nmultiline.val=world");
>  
>  	my $conf = Git::Config->new();
>  	ok($conf, "constructed a new Git::Config");

-- 
Jakub Narebski
Poland
ShadeHawk on #git
