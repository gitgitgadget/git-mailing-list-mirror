From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] diff.h: extend "flags" field to 64 bits because we're out of bits
Date: Tue, 25 Aug 2015 10:39:57 -0700
Message-ID: <xmqqy4gzz2qa.fsf@gitster.dls.corp.google.com>
References: <1440205700-19749-7-git-send-email-pclouds@gmail.com>
	<1440205874-20295-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, plamen.totev@abv.bg, l.s.r@web.de,
	Eric Sunshine <sunshine@sunshineco.com>, tboegi@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:40:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUICc-0008Pj-AK
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbbHYRkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 13:40:00 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34878 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbbHYRj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:39:59 -0400
Received: by pacdd16 with SMTP id dd16so130664238pac.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=aGnizDNXU7NTbr673+TEhqrt4oXqHK6evLkLmquueSM=;
        b=MqBkL+RQ9/6SToTY1dhGpXf5Ks+H1tkmCeSbUMaAzSTU7S98nDdk8n2FehuVtZCy16
         y1AIqYOmB+Bd0h6UepsVlo3PVMx0SvYZIWI5BNx5boTlKaXEeEdx3vUzBdsbF53xn4jK
         FbzcHRkRNNHPubahqwgXh2eEZS6CXUxul6oEcCN2VY49J8NsDIGauAAKElTwcN7WkQeB
         oO3wyMV95y5PDPpo2MZ1jwWnElBKvcQrSoNnmHMLYyidmRHlXdXO3yudqbrVhBSlaM3y
         hGcMv7F5YamhExIRlw0SFD42ZkzUI1gGOiEXKqGXKc/BVK2J2hl1oG83aDXLpCy31IDx
         lmjQ==
X-Received: by 10.69.26.38 with SMTP id iv6mr58929271pbd.151.1440524399188;
        Tue, 25 Aug 2015 10:39:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id eh4sm251600pbd.27.2015.08.25.10.39.57
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 10:39:57 -0700 (PDT)
In-Reply-To: <1440205874-20295-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22
 Aug 2015 08:11:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276550>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> I renamed both "flags" and "touched_flags" fields while making this
> patch to make sure I was aware of how these flags were manipulated
> (besides DIFF_OPT* macros). So hopefully I didn't miss anything.

It is a bad taste to use user_defined_t typedef (I think it actually
is a standard violation), isn't it?

The diff-struct is not like objects where we need million copies of
in-core while running.  What do you need many more flags for?
