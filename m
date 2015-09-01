From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH] t7300: fix broken && chains
Date: Tue, 1 Sep 2015 08:27:59 +0200
Message-ID: <CAMpP7NZ=K62XVkuuJHpDruBy7b2gECHrJ30L43LzdE54vTVB2A@mail.gmail.com>
References: <1440926289-5899-1-git-send-email-erik.elfstrom@gmail.com>
	<20150831185414.GB20555@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 01 08:28:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWf37-0001Ge-Hf
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 08:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbbIAG2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 02:28:00 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34361 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbbIAG2A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2015 02:28:00 -0400
Received: by oiex83 with SMTP id x83so78219470oie.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 23:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=R0yYUeRLyV2+pCzKCarafqaw5WP00k5pyX31MCbMteM=;
        b=hjHPX6Ziuv2YjdBs4yTBkrw5RGwnVCEynAzxKJGc0KTPtv02GcGN0ImGjROuTbBjaL
         M+YSgCJYuJuWeZ2iZOLly5JwARna3bCf5+cv63QZ7imqrsH0oYlhqcGO7QrYcrpye2IA
         YR06pi7c6nNQXhEA57pG/ZigeYNymJ3FSLBranb1wY48MXFaWymjTnDzD0eqD71DKViv
         awENy70WQXu2lywOIVgr0rmdoR50Ed/msy8adFe2eDMmjw2MbhGFsYwk79JhmywN/Hgx
         BvhoYtPj8D+TDzvCOsOWtWs6asAJ5ioDW3OLMoX55jTysvWZ8kKtPBeRNlVSG74SqqeF
         SUIg==
X-Received: by 10.202.215.8 with SMTP id o8mr15265272oig.47.1441088879552;
 Mon, 31 Aug 2015 23:27:59 -0700 (PDT)
Received: by 10.182.116.69 with HTTP; Mon, 31 Aug 2015 23:27:59 -0700 (PDT)
In-Reply-To: <20150831185414.GB20555@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276968>

On Mon, Aug 31, 2015 at 8:54 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 30, 2015 at 11:18:09AM +0200, Erik Elfstr=C3=B6m wrote:
>
> Unfortunately CHAIN_LINT cannot reach inside a nested subshell. I can=
not
> think of a way to make it do so, and besides, that is also the way to
> override the &&-chain precedence. So I think it is not really possibl=
e
> to get better coverage here. And such cases as these are not really v=
ery
> interesting (e.g., here we exclude only minor minor setup steps from =
the
> &&-chain).
>
> -Peff

I actually hacked together an ugly script to check for more broken
chains. It's not working very well and I haven't checked the output
thoroughly but I did see quite a few broken chains. Many are of the
(mostly harmless) form:

     (
        echo "100644 $o5 0    a"
        echo "100644 $o0 0    c"
        echo "160000 $c1 0    d"
    ) >expected &&

I'd estimate that there are hundreds of these (see t3030 for
examples). I'm not sure if you care about these? As you say they are
not really very interesting cases.

/Erik
