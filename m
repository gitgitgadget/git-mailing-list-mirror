From: Jacob Keller <jacob.keller@gmail.com>
Subject: weird diff output?
Date: Mon, 28 Mar 2016 17:26:35 -0700
Message-ID: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 02:27:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akhUp-0007eO-RR
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 02:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbcC2A04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 20:26:56 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34743 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbcC2A0z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 20:26:55 -0400
Received: by mail-ig0-f171.google.com with SMTP id av4so65318805igc.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 17:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Y3Oxzzj6ZjRmC1FoleUa9uEpVnoSb8qQDIDJuu/j+Ec=;
        b=B9bPdu/moX52A+E3tLHxX7iIFB44QGQtd/7HA8emm5T2o4twHHenK7M033BVdwySz4
         2ZWoJcetlFxTPRPYHUBgDxHOiqpE2+xlHYFtE6zvLx4HjERwigeZqWHc+A2U17FNQp0W
         e6REVU5AjAKe10Xsf0KfSwN/vmmM7iEUwsafE6vUvx95TlXB7b/xrLC1t7kxqBV2A8lA
         DSsK4xDa0gye/YgXlt2agyzy66QpCy3MGrSPDSUWfnlPlp6MHvbqnX/8Ut9CpY/1KFKy
         xaf2ll9o9NlNQmlJVk/Fc4HYK1+2n/KRJf02uuOAO85FuYb85PCV6iiwQEdsRDWXo4Py
         zEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y3Oxzzj6ZjRmC1FoleUa9uEpVnoSb8qQDIDJuu/j+Ec=;
        b=TWiYMVYKGtycXJCJLFMlrihp3ruzPc8JHqA+yzLsMfSIOlLTPC7zJdHpnxjLa60yrF
         Muh1EPOH8kXO7WrUeWHZp/+iexpE/4CRCja18vNx35SdtAHn3sxhFFs9M3ObInDpSxCl
         dzV1HLfMRiRIO1aLu7XPxEhHCTV4P/IpQqxij1yKTy2loEUlV73hnk2YIMv2jc1F9NKL
         q6myXe0wiKzIGsAcSIFmhz+az7Ovx6SHnfVVpTXwQUCifF5sTmJgRLBOhoOyOqfI+d2f
         yVJnO1DIUELYbM4fA+SXC6bolllvWRLmM9BN00Kur6tU5N1FewCgGZkNWOsNPJe3NC0V
         zRTw==
X-Gm-Message-State: AD7BkJJNa0aVY+K+pc0Gzz56XYiZdUbJb+suDIPKbwFSjEkulX1oLdikX03KP2uZYZTmUdKWxKNGOi+/mObu0w==
X-Received: by 10.50.112.169 with SMTP id ir9mr12810875igb.92.1459211214397;
 Mon, 28 Mar 2016 17:26:54 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Mon, 28 Mar 2016 17:26:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290093>

On Mon, Mar 28, 2016 at 4:28 PM, Stefan Beller <sbeller@google.com> wrote:
>  cat > expect <<EOF
> +Entering '../nested1'
> +Entering '../nested1/nested2'
> +Entering '../nested1/nested2/nested3'
> +Entering '../nested1/nested2/nested3/submodule'
> +Entering '../sub1'
> +Entering '../sub2'
> +Entering '../sub3'
> +EOF
> +
> +test_expect_failure 'test messages from "foreach --recursive" from subdirectory' '
> +       (
> +               cd clone2 &&
> +               mkdir untracked &&
> +               cd untracked &&
> +               git submodule foreach --recursive >../../actual
> +       ) &&
> +       test_i18ncmp expect actual
> +'
> +
> +cat > expect <<EOF
>  nested1-nested1
>  nested2-nested2
>  nested3-nested3

Complete tangent here. The diff above looks like

<old-line>
+
+
+
+
+<old-line>

is it possible to get diff output that would look more like

+<old-line>
+
+
+
+
+
<old-line>

instead? This is one of those huge readability issues with diff
formatting that seems like both are completely correct, but the second
way is much easier in general to read what was added.

I don't understand why diff algorithms result in the former instead of
the latter, and am curious if anyone knows whether this has ever been
thought about or solved by someone.

I've tried using various diffing algorithms (histogram, etc) and they
always produce the same result above, and never what I would prefer.

Regards,
Jake
