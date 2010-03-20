From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] gitk: Avoid calling tk_setPalette on Windows
Date: Sat, 20 Mar 2010 01:32:56 -0500
Message-ID: <20100320063256.GA26519@progeny.tock>
References: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Mar 20 07:32:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NssET-000542-My
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 07:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab0CTGcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 02:32:10 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:43551 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab0CTGcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 02:32:08 -0400
Received: by yxe12 with SMTP id 12so931695yxe.33
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3EVrlyd+xf2d7rPbrRLh3NcqUOOgB0kW4DZI+M6Sr80=;
        b=ETaL+HUNGCZ6lANlHjHI7mX+UkfQ9ACoyz/vu8GOGkmbpRxwciMLSrmFuTdsCk5Urx
         9u8QyeG39S++1+mjmZwFWttyErOWPjRa4jdexIVLhqE4dz/ppm2yyJm2XrZ293vq+KSX
         83aTbLIxXoJlDHiK9CFsaWrf1pH1eGTVJ/RJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ovgjI37H3ERz18fZ5+tQENaCwnozBOK5tKE/uMQqH1exHWSk7/+gxIIvGc8G8WI39A
         laukvOuqeEQ/C4u9sIBLUmedPUsDg6shB3oiYH+o308Lr99fA86B4rMSUUGow6FrkoGh
         Z4weBCRW3AphGEOgZpvOFb3QXUv/e/iu6tV9Q=
Received: by 10.151.89.31 with SMTP id r31mr2904003ybl.57.1269066725533;
        Fri, 19 Mar 2010 23:32:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm32883iwn.9.2010.03.19.23.32.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 23:32:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142692>

Pat Thoyts wrote:

> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
>  gitk |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 1f36a3e..dc9b8a8 100755
> --- a/gitk
> +++ b/gitk
> @@ -10845,10 +10845,11 @@ proc setselbg {c} {
>  
>  # This sets the background color and the color scheme for the whole UI.
>  # For some reason, tk_setPalette chooses a nasty dark red for selectColor
>  # if we don't specify one ourselves, which makes the checkbuttons and
>  # radiobuttons look bad.  This chooses white for selectColor if the
>  # background color is light, or black if it is dark.
>  proc setui {c} {
> +    if {[tk windowingsystem] eq "win32"} { return }

Do you know whether the situation described by the comment has been addressed
for Tk?  Maybe gitk could check for an appropriate Tk version to avoid this
workaround on all platforms.
