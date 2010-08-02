From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: allow configurations that change with each request
Date: Mon, 2 Aug 2010 21:35:57 +0200
Message-ID: <201008022135.58287.jnareb@gmail.com>
References: <4C4D152A.7050505@gmail.com> <201007261623.05850.jnareb@gmail.com> <20100731030159.GD906@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julio Lajara <julio.lajara@alum.rpi.edu>,
	"=?iso-8859-1?q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>,
	Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 21:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og0o4-0001H2-Lr
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 21:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab0HBTgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 15:36:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63478 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab0HBTgI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 15:36:08 -0400
Received: by bwz1 with SMTP id 1so1608115bwz.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9Mr81LNpTd6V8RqMfDD900RZgHemluseaZJdupLtxso=;
        b=UoswAjfzPfFoiJIehsnT7cFD06mXIqpf3h0utjtNiJ1DtaxhcAAIuiMSguf8Rp4+wP
         6OSchWLgGuHpy48V4ngmEoFeJrDSUhv5hjkoNeBJUIs/7D7kKDQYgJbsAZ47cfsnAcch
         AXlHrJ+D0UhrlwU1m3zYPcgJNttlcvtW3eIHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=w8BGdCowDJ+IL6NncLW3Ipm5p3hemCmRhup1eAXrTczzmc5fyX69UIk3AyXrzUD6m/
         LA+ITrJpmUS1Qc0SqAfp9YDkrsctpSgAM9XWSo5zCTl7Dayxl0UFIKrTavig8fcuECa5
         SjwNTG+W0vTIQrqAZ6nrEjGpZkdjFoGEp8/nM=
Received: by 10.204.0.83 with SMTP id 19mr4497475bka.67.1280777766554;
        Mon, 02 Aug 2010 12:36:06 -0700 (PDT)
Received: from [192.168.1.13] (aeho67.neoplus.adsl.tpnet.pl [79.186.196.67])
        by mx.google.com with ESMTPS id y2sm4364791bkx.8.2010.08.02.12.36.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 12:36:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100731030159.GD906@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152442>

On Sat, 31 Jul 2010, Jonathan Nieder wrote:

> gitolite's contrib/gitweb/gitweb.conf includes:
> 
> 	$ENV{GL_USER} = $cgi->remote_user || "gitweb";
> 
> which is useful for setups where a user has to be authenticated
> to access certain repos.  Perhaps other typical configurations
> change per session in other ways, too.
> 
> v1.7.2-rc2~6 (gitweb: Move evaluate_gitweb_config out of run_request,
> 2010-07-05) broke such configurations for a speedup, by loading
> the configuration once per FastCGI process.
> 
> Probably in the end there should be a way to specify in the
> configuration whether a particular installation wants the speedup or
> the flexibility.  But for now it is easier to just undo the relevant
> change.
> 
> This partially reverts commit 869d58813b24c74e84c9388041eafcef40cb51e4.

Why only *partially* reverts...

...ah, I see, I did "while at it" change fixing timer and number of git
commands info for persistent environments (i.e. gitweb run as FastCGI
script).
 
> Reported-by: Julio Lajara <julio.lajara@alum.rpi.edu>
> Analysis-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Reluctantly-acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
> Jakub Narebski wrote:
> 
> > I wonder if it would be possible to 
> > re-enable this feature (which I think is needed to be able to use
> > $cgi->remote_user) but without having all pay the [slight] performance
> > penalty of including (and I think parsing) config file once per each
> > request.
> 
> I dunno.  Maybe this would be a good place to start.

Currently this is non-issue; the eventual performance penalty is I guess
very small.

The problem would be with adding caching support to gitweb.  While
default GitwebCache::* caching engine should have low startup cost, 
the CHI generic caching interface that one might want to use instead
uses Moose (Mouse with Any::Moose?) for OOP, which imposes some startup
cost.  One enables and configures output caching in gitweb config, so
if gitweb config would be read once per run then cache interface could
be started once per run, not once per request.
 
Nevertheless this change is backwards incompatibile change, and should
probably wait for 1.7.3 (pity that 1.7.2 was so recently released).


One solution I can think of (still backwards incompatibile) would be to
provide $per_request_config variable, which would hold anonymous sub
with parts of config that need to be done per request (this should work
with global variables (our), but I think it wouldn't work with lexical
variables (my)).  For example gitolite's contrib/gitweb/gitweb.conf would
then include:

  $per_request_config = sub {
  	$ENV{GL_USER} = $cgi->remote_user || "gitweb";
  }

What do you think about it?

>  gitweb/gitweb.perl |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e0e9532..300c4b1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1060,8 +1060,12 @@ sub run_request {
>  	reset_timer();
>  
>  	evaluate_uri();
> +	evaluate_gitweb_config();
>  	check_loadavg();
>  
> +	# $projectroot and $projects_list might be set in gitweb config file
> +	$projects_list ||= $projectroot;
> +
>  	evaluate_query_params();
>  	evaluate_path_info();
>  	evaluate_and_validate_params();
> @@ -1109,12 +1113,8 @@ sub evaluate_argv {
>  
>  sub run {
>  	evaluate_argv();
> -	evaluate_gitweb_config();
>  	evaluate_git_version();
>  
> -	# $projectroot and $projects_list might be set in gitweb config file
> -	$projects_list ||= $projectroot;
> -
>  	$pre_listen_hook->()
>  		if $pre_listen_hook;
>  

That reminds me: '$projects_list ||= $projectroot;' line should be put,
I think, inside evaluate_gitweb_config().  But that of course should not
be done in this patch.

-- 
Jakub Narebski
Poland
