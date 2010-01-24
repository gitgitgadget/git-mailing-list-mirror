From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/9] gitweb: Add option to force version match
Date: Sun, 24 Jan 2010 15:17:56 -0800 (PST)
Organization: 
Message-ID: <m3iqarayar.fsf@localhost.localdomain>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
	<20100124215924.GA9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 25 00:18:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZBib-0004C5-UH
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 00:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab0AXXSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 18:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758Ab0AXXSB
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 18:18:01 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:52573 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab0AXXSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 18:18:00 -0500
Received: by fxm7 with SMTP id 7so1429304fxm.28
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 15:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=KxoWuBWM3Usb8zfqwRRH5B+TPgtEP9R5saFlPfg7eqY=;
        b=AYy4vfUQeJimTJbDaVs4i4QJnGbBsaYOvPtflLELQLKNLORyu7LCBQJ68LhMqcOhm3
         Kv05PVifEtfvfc7DjkZ2hvWYHP9PkIrG4kdFe5ivQBD0oHENH+XuoTGyDaekfcJLZUeW
         csMD6T9FxZSmDGPQpSHq6Bp7oA0932I/wwbew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=L7RgkIX5axM96Qp97eqBcN2VOGEOvsrg9CzA5HxXHRF5ULai+wpgcfdYX8pLlDf34n
         mLuLUUARLa7YiAeSfuIim7H23zMS40tsWrXf/TYq6/6SLtd6hG8g/48uRVAf5Ygx+XvK
         2lPoZFkf5VZojXqbAMvQjytN+wm/a+0Q1dEl0=
Received: by 10.223.59.3 with SMTP id j3mr469280fah.46.1264375077990;
        Sun, 24 Jan 2010 15:17:57 -0800 (PST)
Received: from localhost.localdomain (abvk247.neoplus.adsl.tpnet.pl [83.8.208.247])
        by mx.google.com with ESMTPS id y15sm5929742fkd.56.2010.01.24.15.17.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 15:17:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0ONHDnV018514;
	Mon, 25 Jan 2010 00:17:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0ONGj6i018509;
	Mon, 25 Jan 2010 00:16:46 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100124215924.GA9553@machine.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137925>

Petr Baudis <pasky@suse.cz> writes:

> On Wed, Jan 13, 2010 at 05:22:59PM -0800, John 'Warthog9' Hawley wrote:

> > +# Throw an error if git versions does not match, if $git_versions_must_match is true.
> > +if ($git_versions_must_match &&
> > +    $git_version ne $version) {
> > +	my $admin_contact =
> > +		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
> > +	my $err_msg = <<EOT;
> > +<h1 align="center">*** Warning ***</h1>
> > +<p>
> > +This version of gitweb was compiled for <b>@{[esc_html($version)]}</b>,
> > +however git version <b>@{[esc_html($git_version)]}</b> was found on server,
> > +and administrator requested strict version checking.

+and administrator requested strict version checking by setting
+\$git_versions_must_match to false value (e.g. to 0) in gitweb configuration file,
+'@{[esc_path(-e $GITWEB_CONFIG ? $GITWEB_CONFIG : $GITWEB_CONFIG_SYSTEM)]}'.

> > +</p>
> > +<p>
> > +Please contact the server administrator${admin_contact} to either configure
> > +gitweb to allow mismatched versions, or update git or gitweb installation.
> > +</p>
> > +EOT
> > +	die_error(500, 'Internal server error', $err_msg);
> > +}
> > +
> 
>   I get very unhappy when *I* am the server administrator and read
> messages like this. ;-) Could you please mention the
> \$git_versions_must_match in the text?

Something like the text (extension) proposed above?


Actually, J.H., if you are changing the default, you should also change the
message to mention that checking versions is the default, and administrator
can turn it off[1].  It is incorrect if $git_versions_must_match defaults
to true.

[1] And you have to take into account that gitweb config file can not
exist, and neither $GITWEB_CONFIG nor $GITWEB_CONFIG_SYSTEM needs to be
non-empty.  J.H., are you really, really sure that it is a good idea to
have version check turned on by default, in light of this issue?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
