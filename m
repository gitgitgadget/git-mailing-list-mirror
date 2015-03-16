From: Cody Taylor <cody.taylor@maternityneighborhood.com>
Subject: Re: [PATCH v2] git prompt: Use toplevel to find untracked files.
Date: Sun, 15 Mar 2015 20:54:08 -0400
Message-ID: <CAHWMk2aq7dW5nBW1f8T4TWfRC70hp-6kR5P79m_E4zccuy53aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 01:55:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXJIO-000848-8a
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 01:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbbCPAyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 20:54:11 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34081 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbCPAyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 20:54:09 -0400
Received: by obbgg8 with SMTP id gg8so24892332obb.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 17:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=qAAv2SiE2Y7Ys8NkWPkcbSRTscluISwjdhZSfG4Q0tw=;
        b=d6w/HH7rYrH8ONGM320VHhAqgrEKjtIoWMRmQ1Rf4cdjxQRasS1GL4ZZ3Yqt2NQBYG
         hg60IViAK91vGH/UJt0qxn6bfaWEH+dqS4RSXaJz+jbd4othSJ+1d6wI752BQiYr/wjC
         UJBdJpzoZFY57kxa22J9Covni8KLYaEZGD+TqXYTL8w7axXsBuxjkFNGMnB6UhfM81Dq
         kEKBSwO0JB15AwiAD5y9xbtSqA6zvHZ6ImsOSBueTlPFcd3b9cyCONDi0Dzj4Ld5Dq2r
         Ad1gEi0wJEHhKxewSveSbXhse+x6P3BiN9ukdfyf3R9co9yoSQiIk3g9ZbEcfhhOx1PQ
         H1RA==
X-Gm-Message-State: ALoCoQm+nqWJtCsuCxFgcY2ipaa13TfV7KlY4Zafb1tAhIXpiHigqndNzM/DZOqpQ/WSDO77yO/O
X-Received: by 10.60.33.106 with SMTP id q10mr13257614oei.67.1426467248957;
 Sun, 15 Mar 2015 17:54:08 -0700 (PDT)
Received: by 10.76.109.37 with HTTP; Sun, 15 Mar 2015 17:54:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265539>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
> Somehow I had a hard time making sense out of "when the current worki=
ng
> directory was not a parent of the untracked file".  Perhaps "when the
> untracked files are outside of the current working directory" would b=
e
> easier to grok?

That description doesn't cover all cases.

Scenario #1: Let's say there is an untracked file at `$ROOT/file`.
When your CWD is `$ROOT/`, all is well. If you cd to `$ROOT/src/` the
ls-files command failed to find the untracked file.

Scenario #2: Let's say there is an untracked file at `$ROOT/src/file`.
The ls-files command would find the file if the CWD is `$ROOT/` or
`$ROOT/src/`, but not if the CWD is `$ROOT/bin/` or
`$ROOT/src/folder/`.

Your description may be easier to understand, but I don't agree it's ac=
curate.
