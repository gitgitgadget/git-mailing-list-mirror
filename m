From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: fix filetype detection on files opened exclusively
Date: Thu, 2 Apr 2015 20:54:32 +0100
Message-ID: <CAE5ih7_QpkX-U+XJ8gKSKKt1+Vu+FM4XBADTkys-4MDa129jyw@mail.gmail.com>
References: <2D2A7688059E344DB86768405D63DEB42D3D75FC@USCULXMSG09.am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>
To: "Holloway, Blair" <Blair_Holloway@playstation.sony.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:54:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdlCJ-0001sI-9s
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 21:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbbDBTye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 15:54:34 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:32980 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbDBTyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 15:54:33 -0400
Received: by obvd1 with SMTP id d1so145695410obv.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=11xS/WB+oqtwWs/0M6WGNApKrL1Vc6LOvrmhDtylFyE=;
        b=PioCeD5FfLaLFscDJkNjHAyUkxb3POJPlpUksBct8NaOtCW0y+yVqF+XTSBSTonVMf
         m02fvtkH08x8gPSWH9L9jhRGYhAq+ewDQLNlBf2p21lN0WsOk/MIaLWfnGO9aTiK0zG/
         fSv195iUfxPMMCAKy7CDurovualg79+YwyGm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=11xS/WB+oqtwWs/0M6WGNApKrL1Vc6LOvrmhDtylFyE=;
        b=MeUWQ8kFEvuG+pbChntZ5J6tjuQCKLHEL5IVciICn8T8D+hBV5jMLEgyIeXOuYl/KU
         WoO4fCU5aY52QI/aYjomBoGuEdjcsU9jp3GqYOfuCKgk/zeFZNfeWAPBJh3baYKc2nfS
         AGrwsLlMBqgJ614pNpUdv5J6gGOTqsjXVBOY/SoAMRC9mL58xwgYa7o16cVkvy0yp03q
         cQArsAQN1aN+5hVqBC6C7LN7nRQkz2i1PIsTmpN2Wzx76cE92e8AgBIZfB8IWBrbpQSN
         XSr6JYJ2w1Hq76LzSRGpZaeS+ZVRP8oYh/tp1exGPJxYsTJa8Hhejv3hwoSawIrYlpIv
         fISA==
X-Gm-Message-State: ALoCoQmkjNnWwA1bqTDtUwZrN+eSEXP7hs8Ov9F1Z1LMJ/zR9oUIyUX0Xmko5UAdm7N1KlqRcHY4
X-Received: by 10.182.87.8 with SMTP id t8mr48348854obz.35.1428004472345; Thu,
 02 Apr 2015 12:54:32 -0700 (PDT)
Received: by 10.60.162.74 with HTTP; Thu, 2 Apr 2015 12:54:32 -0700 (PDT)
In-Reply-To: <2D2A7688059E344DB86768405D63DEB42D3D75FC@USCULXMSG09.am.sony.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266664>

(+Pete for interest).

On 31 March 2015 at 22:54, Holloway, Blair
<Blair_Holloway@playstation.sony.com> wrote:
> If a Perforce server is configured to automatically set +l (exclusive lock) on
> add of certain file types, git p4 submit will fail during getP4OpenedType, as
> the regex doesn't expect the trailing '*exclusive*' from p4 opened:

Thanks - that actually fixes a part of the long-standing problem of
handling locked files which Pete identified about a year ago.

There's a test case for handling of locked files,
t9816-git-p4-locked.sh, which needs updating now as a bit more of it
passes. Junio, I'll submit a followup patch to update those tests once
I get back from vacation.

(Fixing t9816 is very slightly non-trivial because test #4 is subtly
broken and so incorrectly passes).

Ack,
Luke
