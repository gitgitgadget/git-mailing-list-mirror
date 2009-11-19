From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb.js: fix null object exception in initials calculation
Date: Thu, 19 Nov 2009 22:40:26 +0100
Message-ID: <200911192240.27743.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <1258659887-5244-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 22:40:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBEk7-0001gc-Og
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 22:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185AbZKSVkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 16:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755837AbZKSVkb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 16:40:31 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:57623 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbZKSVka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 16:40:30 -0500
Received: by fxm21 with SMTP id 21so2926219fxm.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 13:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dA79bJZgl5eQzds3GIJPWQ8cdWERqSTMUx733esVCHA=;
        b=K1o++y4lCfRGavKHid0p1GKq5jPBsvdXHabpAcVQmLSfZtaFu0tCQ8N0XixW9xRsU3
         SaAJtZRcK2qyPmFLWMnteDEkMgjCimcu3SCZXSIBu2znLZsALiTQfnSGv11B4MFnkYdt
         uHkgsAS5tS2fxLfmT4DuFM9EQcCGifzJ9+Qs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FUdkGZZlWhANgH4YCOiuVQXcRWxGJK2GScFe17HhIcrbhkNu61dexbS26kl1VVRgZt
         mXddz15I3pnJqwyNwtzFe8Tfk7oaJGGQlekBrUx5e/7WVGkCRBajyvtizkzi5iHC67UW
         4jM/eY6sLsTRzoPfUYAbyMlPJDy6BBDFLhsrI=
Received: by 10.103.50.22 with SMTP id c22mr257862muk.54.1258666834792;
        Thu, 19 Nov 2009 13:40:34 -0800 (PST)
Received: from ?192.168.1.13? (abvd116.neoplus.adsl.tpnet.pl [83.8.201.116])
        by mx.google.com with ESMTPS id 23sm4116284mun.11.2009.11.19.13.40.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 13:40:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1258659887-5244-2-git-send-email-bebarino@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133259>

On Thu, 19 Nov 2009, Stephen Boyd wrote:

> Currently handleLine() assumes that a commit author name will always
> start with a capital letter. It's possible that the author name is
> user@example.com and therefore calling a match() on the name will fail
> to return any matches. Subsequently joining these matches will cause an
> exception. Fix by checking that we have a match before trying to join
> the results into a set of initials for the author.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---

[From "[PATCH 0/2] jn/gitweb-blame fixes"]
> This series is based on next's jn/gitweb-blame branch.
>
> I was trying out the incremental blame and noticed it didn't work
> each time. The first patch fixes the crashing I experience when
> blaming gitweb.perl (ironic ;-)

Hmmm... gitweb/gitweb.perl *was* one of files I have tested 
'blame_incremental' view on, but I have not experienced any
crashes.

Perhaps it was the matter of different JavaScript engine (Mozilla 1.7.12
with Gecko/20050923 engine, Konqueror 3.5.3-0.2.fc4), or different
starting point for blame.

I assume that crashing lead simply to not working blame, not to browser
crash?

>  gitweb/gitweb.js |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
> index 22570f5..02454d8 100644
> --- a/gitweb/gitweb.js
> +++ b/gitweb/gitweb.js
> @@ -532,8 +532,11 @@ function handleLine(commit, group) {
>  			if (group.numlines >= 2) {
>  				var fragment = document.createDocumentFragment();
>  				var br   = document.createElement("br");
> -				var text = document.createTextNode(
> -					commit.author.match(/\b([A-Z])\B/g).join(''));
> +				var match = commit.author.match(/\b([A-Z])\B/g);
> +				if (match) {
> +					var text = document.createTextNode(
> +							match.join(''));
> +				}
>  				if (br && text) {
>  					var elem = fragment || td_sha1;
>  					elem.appendChild(br);

Thanks.  It now corresponds to what it is done for ordinary 'blame'
view, i.e.:

	my @author_initials = ($author =~ /\b([[:upper:]])\B/g);
	if (@author_initials) {
		print "<br />" .
		      esc_html(join('', @author_initials));
		#           or join('.', ...)
	}


P.S. Unfortunately unless we decide to generate JavaScript from Perl code,
using something like GWT for Java or Pylons for Python, e.g. CGI::Ajax
(which is not in Perl core), we would have to have such code duplication.

-- 
Jakub Narebski
Poland
