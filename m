From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] completion: add tests for the __gitcomp_nl()
 completion helper function
Date: Sat, 17 Nov 2012 15:31:54 -0800
Message-ID: <20121117233154.GC3815@elie.Belkin>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
 <1353150353-29874-4-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 00:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZrry-00081c-KN
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 00:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab2KQXb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 18:31:59 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41641 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab2KQXb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 18:31:59 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2686184pbc.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 15:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jNmRw9wh8TAv7VuiBNGCS7wMURKPTxuQjpok4IN/Wag=;
        b=bA6X52xC4gQ2LMVv2ZrwigXtQ21O3ieSr9ENVtIg3S2CkVPt8kwYccXQWGtlJDS3x7
         if0BVo8pARSLd1V6ymZFXf/8+txmxP9aDaxcM6wtcT6NpiAWDzQxDznEXer+KzjIn9jr
         TiX8SuaheCGLvdtLLBB8mb4VacqFNijz6+/86rm0VBuM4yKrH++5kTulb4xiU0uyx3TY
         8Ly+/2s1zhLrkhxsHoCg9G/52nCkURciZsfJatGOYO8N5LT8N9PBdevep/CflPbs0ZfX
         rmVREIKMppxXr1s+IJGFFEIPr5odoXp1GX8FG3xnDQgAY5YyrwXu6MCKPF6yeUYCULQG
         cdUg==
Received: by 10.66.78.136 with SMTP id b8mr24823387pax.26.1353195118722;
        Sat, 17 Nov 2012 15:31:58 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ve6sm3550749pbc.58.2012.11.17.15.31.57
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 15:31:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353150353-29874-4-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209985>

SZEDER G=C3=A1bor wrote:

> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -155,6 +155,90 @@ test_expect_success '__gitcomp - suffix' '
>  	test_cmp expected out
>  '
> =20
> +test_expect_success '__gitcomp_nl - trailing space' '
> +	sed -e "s/Z$//" >expected <<-\EOF &&

'$' is usually a shell metacharacter, so it would be more comfortable
to read a version that escapes it:

	sed -e "s/Z\$//" >expected <<-\EOF

Since '$/' is not a valid parameter expansion, if I understand
correctly then POSIX leaves the meaning of the quoted string "s/Z$//"
undefined (XCU =C2=A72.2.3).  Luckily every shell I've tried, including
bash, keeps the $ unmolested.

Other parts of the file already use the same style, so I wouldn't
suggest changing it in this patch.

Thanks for some nice tests.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
