From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 41/44] am: use be_silent in 'struct apply_state' to
 shut up applying patches
Date: Sat, 11 Jun 2016 12:07:53 +0200
Message-ID: <CAP8UFD2aP7gkLQpG1iFBpY-9wO2kPh8Os4E9RQc2Jtdve2QUqg@mail.gmail.com>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
 <20160610201118.13813-42-chriscool@tuxfamily.org> <xmqq4m90elz5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 12:08:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBfpj-00007a-68
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 12:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbcFKKH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2016 06:07:57 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37733 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcFKKHz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 06:07:55 -0400
Received: by mail-wm0-f49.google.com with SMTP id k204so20438500wmk.0
        for <git@vger.kernel.org>; Sat, 11 Jun 2016 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ybOBA9vb2+csELKDL7UgMx+doLFYqhyTFAHV2/m5Ll4=;
        b=LTmGZvCGvbUn2X2/hEpVB3jAhXNCb05aE535DRzCYvAW1EL+yEwZGGmCzL4NhJ+PhS
         Od15UeRidxrYtdxZLPdllSXvGwHB/eLJ5y2JJFngCcQ9NlIrBWa0e4ZE05krFgqXTFij
         g8AVgaaRSpT2c+vHsY22T+745JCXd7oqHIGveY+jG6meNbIvXI3CMnJFxpOybyDMEIwl
         BYZbGcNznl/uiE70ZXFnrR7SIhdU1MJvrRl3BmoFmQoqBaV+Cqw/EEI5PsTQaqnivKxu
         O5dr6pE/odWfaS1iC1/SlhzqvEjUuAbD5TVP09nJkVdirJEwph4pvxxC1p7pcM8tB1g8
         q1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ybOBA9vb2+csELKDL7UgMx+doLFYqhyTFAHV2/m5Ll4=;
        b=hB4gpRb8gFcwACU/tVPyTlkOtcHdarfRzp8QkeFvkCUqBFAY7aeDYOoj30i5SEwArj
         gsadyoTG79YVDT/GW4Vax0GdoOyqGhYWK2wBvQUIGeUOgr79qX0RcpcFVrRBvXEoaFfj
         oYyFEuHzswAVXgUv8so79gv+xztBCA4Wegk5S4WlmC0LDdjmRFSRmCcnbxxRFECeEhZK
         pwRsmCrKVSg+jIHTOLfsucZnvthLT7KOe1olfdUdbd1vDGnE16/M+kC44ROrUkOllr4u
         1M55jFdgOXJiEK2W7l/xIfy1VvUy8iueIiQsknzlXr2g0zIkSFEjbRRbgrR6YEWti+lw
         6agQ==
X-Gm-Message-State: ALyK8tK7dNUNr2Yq55lNcm2mEO9JdrmJZltqTt0T5Z7wi9OTy2z/z92ujngW/kRLUfjsHxP7332HMcLTBU4ibw==
X-Received: by 10.195.17.138 with SMTP id ge10mr6521214wjd.94.1465639674255;
 Sat, 11 Jun 2016 03:07:54 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Sat, 11 Jun 2016 03:07:53 -0700 (PDT)
In-Reply-To: <xmqq4m90elz5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297092>

On Sat, Jun 11, 2016 at 12:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The update in 33/44 to make am call into apply that is not ready to
> be called (e.g. the caller needs the dup(2) dance with /dev/null to
> be silent) gets finally corrected with this step, which makes the
> progress of the topic somewhat ugly and reviewing it a bit harder
> than necessary.  As it stands, the last several patches in the
> series smells more like "oops, we realize these things were not done
> properly the first time, and here are the follow-up patches to fix
> them up".
>
> I wonder if it is a good idea to delay integrating the apply
> machinery into "am" until it is ready?

Ok, I will do that and I think it should also avoid the build failures
on Windows.

Thanks,
Christian.
