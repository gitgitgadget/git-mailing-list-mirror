From: Diggory Hardy <diggory.hardy@gmail.com>
Subject: Re: LESS env var and a pager
Date: Fri, 31 Jul 2009 14:25:41 +0200
Message-ID: <31718a220907310525v681eb2c4l53c41fdec32f3f72@mail.gmail.com>
References: <31718a220907300010t136885c6ldc2ea362f9c6e33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 14:25:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWrBG-0007S9-Bj
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 14:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbZGaMZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 08:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbZGaMZm
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 08:25:42 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39061 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZGaMZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 08:25:42 -0400
Received: by bwz19 with SMTP id 19so1158398bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=9R8JPDz9RSHfU3v7Iv36kCgbmWYOW9vv8llUU+j/hyo=;
        b=jLXhPEXrUweY3FJm2vIDetlw++B3PgxunSG5N+NXQJp3gmOWKnHzlTIqJj1JatQezR
         LwcTBZCY0t2fNzNm9cPzc+oR4YAl9lXpqIF8+nhqOSKmAn2JmRN7i41q+XDb0KnYA8ww
         JPv5zgUuQIF+BE3G731SI4UEhm/RzOYo05eA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=QonKhCQuZcdL13jD2d1CuqBOCS+EmVB0DYFE31kciurlDuhD6JeUnwUXEhjPw6GWf+
         +U08axB4wqY4thRxoeo8buY8gEd7G3RdOckDlgwb0zFdMlXP0w4G5Jsm5PHbItQrNfqB
         C6Pnxcv3D3mEGa+Vpw6j+1FQFkHmrVABWb5no=
Received: by 10.204.52.72 with SMTP id h8mr866719bkg.30.1249043141509; Fri, 31 
	Jul 2009 05:25:41 -0700 (PDT)
In-Reply-To: <31718a220907300010t136885c6ldc2ea362f9c6e33@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124551>

Unfortunately using F without X results in output no longer than one
screen not being displayed, since less immediately exits and anything
less would display is immediately cleared from the screen (so it just
looks like the git command had no output).

I looked through less's man page and didn't find any solution other
than also not specifying F, which is not so desirable since it's
always necessary to press 'q' to exit less and previous output is not
visible on the terminal.

[So don't follow my first suggestion.]

On 30/07/2009, Diggory Hardy <diggory.hardy@gmail.com> wrote:
> I was recently trying to work out why when git's output is piped
> through a pager, it doesn't use the alternate screen buffer:
> https://bugs.kde.org/show_bug.cgi?id=201899
>
> Conclusion: removing the X option from the LESS environ var produced
> the results I wanted (allow mouse-wheel scrolling, output is hidden
> after closing the pager).
> One relevent post I found:
> http://article.gmane.org/gmane.comp.version-control.git/29565/match=less+frsx
>
> So maybe it'd make sense to change this in pager.c to:
> setenv("LESS", "FRS", 0);
> (or even just FR:)
> setenv("LESS", "FR", 0);
>
> Just a suggestion of what seems preferable to me.
>
