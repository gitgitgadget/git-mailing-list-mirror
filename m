From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Why does git-patch-id(1) sometimes print two lines, one of which has
 commit = 0000000000000000000000000000000000000000
Date: Wed, 16 Feb 2011 15:56:32 +0100
Message-ID: <AANLkTimHvA_LsU4YaiDHDKoXnsk5WgGCXgbuSJ99emXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 16 15:56:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpioK-0004SL-Ot
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 15:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab1BPO4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 09:56:52 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56148 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab1BPO4v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 09:56:51 -0500
Received: by fxm20 with SMTP id 20so1464283fxm.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 06:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=TxBoZ3FyLF73ojiPmzxbTwrTRY4ES9ljI8RtyVvNDfc=;
        b=nuAJgi6hqdBLZFXxqtmR4+ZPKQPibJ7/MODFWgb+25+Fp72P42N62Nt0zJsTTkv69i
         Y6V8icUknh4NxcWWudJ1z8v5Xykq7KkSQ+E3CloLi7ULG9JEVRcFC1S2CWTLFpt4LCFg
         CMBMzYWG2zq6qJEdne01LgFZ59UalzL9OQtl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=EeilTUGAvX8dUipUFPPbfL+1BtMAvyXolL8MvCWK4SpgFB/Th0txMZWeLyWJrsECzm
         CpdsfMQRvLP9c/ilh6RQfzPva2zXR+OjX6+A3z5MPqoORpZzixPRyp6NhPeXl6UiJSB0
         41BtoelnElP3SWxa6nNI6hchwZuHPpgnXmu8w=
Received: by 10.223.54.132 with SMTP id q4mr850428fag.117.1297868192121; Wed,
 16 Feb 2011 06:56:32 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Wed, 16 Feb 2011 06:56:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166969>

This behaves as I'd expect on git.git, i.e. shows a patch id and the commit id:

    $ git show 24231e063f0f003f8ffd7b64c7ba6a0baaaa5283 | git patch-id
    f10c69e0e5b33da206f37bd93639875555ac9b79
24231e063f0f003f8ffd7b64c7ba6a0baaaa5283

But what does this mean, also on git.git:

    $ git show 7d48e9e6f77d336376c1a554eeff0590f77e1ee1 | git patch-id
    4ba8a248731c5fcbd09cacb248d3128e742d1c90
7d48e9e6f77d336376c1a554eeff0590f77e1ee1
    d019b35e0b859cdd6907ee170927de1124c0ed6e
0000000000000000000000000000000000000000

7d48e9e6f77d336376c1a554eeff0590f77e1ee1 is just one of the commits
that results in this output:

    $ git log --pretty=format:%H -p | git patch-id | grep
0000000000000000000000000000000000000000
    d019b35e0b859cdd6907ee170927de1124c0ed6e
0000000000000000000000000000000000000000
    3b23a2a11055aef557369971e825010879a8c4d7
0000000000000000000000000000000000000000
    d498fbbad6f1374d952925df699da237c3e8f2df
0000000000000000000000000000000000000000
    b0c930dc1926ffae9cca022797856762fa908be6
0000000000000000000000000000000000000000

And on another repository where I'm dealing with this I have a bunch
more of them.

Why are they there and what do they mean? Maybe it's a bug, or
something I can explain in the manual page.
