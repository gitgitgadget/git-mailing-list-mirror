From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Tue, 11 Mar 2008 13:58:26 -0400
Message-ID: <8ec76080803111058i19d3ae42g87366b31f3df4045@mail.gmail.com>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com>
	 <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain>
	 <8ec76080803111014w209e1ceep9baf6d5c8c7f6a20@mail.gmail.com>
	 <20080311173536.GA14687@sigill.intra.peff.net>
	 <20080311174045.GB14687@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Asheesh Laroia" <asheesh@asheesh.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 18:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ8kn-0005mM-So
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 18:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbYCKR63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 13:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbYCKR63
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 13:58:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:31271 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbYCKR62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 13:58:28 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2624041wxd.4
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SZr717Cko6xIBTogUQSFMW2l7W5GRmmmMCvH9XDEM24=;
        b=OpXWKq9hz9Aud9Oahq0H4geoFondcZZXqO6xoV6Mhm3cG/2F+hPX4gg1r9aCKjzOvw/pWCm4bDB2sSvPGLX9WImnnwq7sGGFr01lDjuUC2Ul0TC+rwErkBsm1/UgBWZuhVv/8uoBtEKxPrvlscaHqqze3cMjlWtQXolxyJvpGJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FUpqFnCRE43cTCRwboQM4ZOj2/gDLSTSjfTmVnZ3fY24EYXjkZl6DZcEjwkb1fUKDhqdPkOVwGsQp9JK0uESxE9titXKWku2rvtlWI0crfWext1i+hVVk85C0FWNkSaJlEL8DQjYX2p1A+TliGSPMLnBi6CxIQ9XGl20VFwivxg=
Received: by 10.141.163.12 with SMTP id q12mr4510008rvo.265.1205258306665;
        Tue, 11 Mar 2008 10:58:26 -0700 (PDT)
Received: by 10.141.201.19 with HTTP; Tue, 11 Mar 2008 10:58:26 -0700 (PDT)
In-Reply-To: <20080311174045.GB14687@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76888>

works great.  thanks.

running rest of test suite now.


On Tue, Mar 11, 2008 at 1:40 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 11, 2008 at 01:35:37PM -0400, Jeff King wrote:
>
>  > Looks like /usr/ucb/tr is OK with this, but /usr/bin/tr is not. Both
>  > seem to handle the more verbose:
>  >
>  > tr \
>  >   'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
>  >   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
>
>  And here it is in patch form.
>
>  -- >8 --
>  t0021: tr portability fix for Solaris
>
>  Solaris' /usr/bin/tr doesn't seem to like multiple character
>  ranges in brackets (it simply prints "Bad string"). Instead,
>  let's just enumerate the transformation we want.
>
>  Signed-off-by: Jeff King <peff@peff.net>
>  ---
>   t/t0021-conversion.sh |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
>  diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>  index cb86029..8fc39d7 100755
>  --- a/t/t0021-conversion.sh
>  +++ b/t/t0021-conversion.sh
>  @@ -5,7 +5,9 @@ test_description='blob conversion via gitattributes'
>   . ./test-lib.sh
>
>   cat <<\EOF >rot13.sh
>
> -tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
>  +tr \
>  +  'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
>  +  'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
>   EOF
>   chmod +x rot13.sh
>
>  --
>  1.5.4.3.621.g34987
>
>
