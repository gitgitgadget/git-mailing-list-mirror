From: Stefan Beller <sbeller@google.com>
Subject: Clarification on Submodule/Subproject naming
Date: Tue, 6 Oct 2015 15:00:44 -0700
Message-ID: <CAGZ79kYyagjxyV0Da3FW3zWuJ+wD=FTPvzYebV7ER4TjTnMXpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Oct 07 00:01:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjaI8-0000EM-H7
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 00:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbbJFWAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 18:00:52 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34708 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbbJFWAp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 18:00:45 -0400
Received: by ykdg206 with SMTP id g206so216143000ykd.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=uEwWqAsghrfiJ9sdbbFVJHiLUNHWjMia0iwLCS8WpUQ=;
        b=jH6oG8j8nQDanP7klzbkqtO/lE9kTV/o6rza3wq0DKIxFAwnS/Q1m9rD1AZX1HHFEb
         QyKMiU4qsTST0ku/4hDkK7jJzGXI5B0P6NXjMO8e7IcIrkdguehJJZIxGogULq93haU6
         cY9PrzzAYSS+wK84tjQQIgNdXosaviA2MZRDYzY5S+Lvh6tlq/IXDH1ztUVmaEgPjpax
         CWIl6GvXz7TAJKjCHZ9cwY25s448pwnqPQ5ns1R6n0lwDfhdvtBZh6SJEk44sY7A8aVT
         5wwiCFPSoQXnevdsuOdR9IJPb683NENtj0ki8YXYuvNG781APLvHvM0B3yt1MwEuqF5u
         ti8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=uEwWqAsghrfiJ9sdbbFVJHiLUNHWjMia0iwLCS8WpUQ=;
        b=I1PdqaDGbStvEU8bI55H8Lp+/s4vdWs/okcAfQw8jiibZLwZbrKcVsAw8ki5Etf4Ru
         JXCqCc7nRU9MIl+vSZhDXh0fPllIxXSfX0D9krLqVJ9Orya4wO5u2blt8jVjSZ+M2h6c
         stDGejNTfkMSWq+ZZ9qTsEQoxwWzXeps0K/tg/TRydf+AJ3Am80UnkCNq0V2lhwIZ66h
         vWzMmEkJePaLLr7bfjBjdc0hNXpVQ2tIAN8m0LfrPirIfky9iDpqq5m+TNXZ1mS6Qprg
         EY+HKtAJo3vnlyOmoyZT3FYjAC927K3D1oaEl2IsnObjT8cxdgHB/ATLD2lrAVgLHahF
         VZXw==
X-Gm-Message-State: ALoCoQk9RhBEvJSCDNSZ+yrFPQDg5SpQNKOStrZW1zIllTiEz9Y1LXw14JnLeb763BkcFrp5sEmy
X-Received: by 10.13.198.194 with SMTP id i185mr30478648ywd.68.1444168844917;
 Tue, 06 Oct 2015 15:00:44 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 6 Oct 2015 15:00:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279166>

So a discussing started in a Gerrit change [1] if we want to name it
submodule or subproject.
We decided to stick with the git core convention of naming it
subproject for now.

But that lead me to the question: What is the difference of a
submodule and a subproject?

As far as I can tell they are synonyms (internally also called
GIT_LINK, but we never expose that to the users), where the term
submodule was coined later in the game, subproject being there as the
first term introduced in version 1.5.

So is it worth to unify that same concept hiding between two names?

Looking through the code we cannot switch to submodule as the literal
string "subproject"
is used for diffs in the plumbing layer.

But getting rid of submodule is also not easy, as there is
git-submodule.sh as a direct command.

So then there is also git subtree, which "allow subprojects to be
included within a subdirectory of the main project, optionally
including the subproject=E2=80=99s entire history." (the man page)

So can I understand a subproject as either a submodule or a subtree ?
If so would it make sense to add an entry to gitglossary to state that
subprojects are generic term for
having some kind of structure? (a subdirectory containing independent
stuff could be considered a
subproject. i.e. We could make contrib/examples the historic-git subpro=
ject ?)

Any advice welcome!
Stefan

[1] https://gerrit-review.googlesource.com/#/c/70948/
