From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 17:16:57 -0700
Message-ID: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 01:17:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afz95-0005Iq-JG
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 01:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933890AbcCPAQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 20:16:59 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35019 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933825AbcCPAQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 20:16:58 -0400
Received: by mail-io0-f179.google.com with SMTP id g203so44580706iof.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc;
        bh=kEmu1ntZPhZ3fE6ILD0u42S76PSwSO/8BxvElIJG0b0=;
        b=sgf+owtALdxfyZH6fRoPZPFVuHfKbUvUR/4Z92c2g6p7tfPC1n8H607afuGHCtVuWB
         /9rKzdEoOeF3hmIzgdveXzNN8dT1QiNlyphrwjVjP6UrClOwtB16RZdlrBI83kMIXGz5
         gIAzrcXHFnYpTklLZ0cN8KKyQSB7ZMoBkkOujBijV48CN21BKJAb0q0CKiUTa1l+ad7+
         F/IXRMs2d8ie00Pp8p7J1vLl6WUewCQsWCXC5U6a0dArV+9kOP6El6x1tICDXcqN8UWp
         IEEeOo/OTUfObZsaumzr1IScstrN0/yvrIyRD8YL+SvxIM3fiyVF72K53UHgHbIMSfEj
         vNNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:date:message-id:subject:from:to:cc;
        bh=kEmu1ntZPhZ3fE6ILD0u42S76PSwSO/8BxvElIJG0b0=;
        b=D6EoY6Hcw4Y46lOWXKR0MVXXWhgkV/8c0MS0PGI3w5D6hX0C57AqEuudhf/GQbXMR1
         XTUIBK92S5MhHCxQw+zMBWuuMt9E4WMZNoUYEPwN0Rmu4O2TZK4zSo7BwJ/KKJnA8Z00
         58GIu9kyvVZ5Qv6eO8ooqrRhwUbUvBc2/OHOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:cc;
        bh=kEmu1ntZPhZ3fE6ILD0u42S76PSwSO/8BxvElIJG0b0=;
        b=AihUNOLZ1y+5h0ZYFfAQHpw6RMFUiL4KIZ0knN5eRDGbhRdCWfbb6TNRsLXe7UYqLM
         YfTsVGKEp//jgFRgAcP5nREbDPaNguoDNz8c369U/UAXiiosFUn9iZ/4ojHeQXDMs9jz
         32ofLgcRWyAlasaENLXkgY1LozWzmj0Arh+EowdenF1KGQSDEL/VLLURvbNWnqbLDFDH
         /HtB/WlvuYd4vYZPEDZ5dDe+cXNlMbZNbDavGdTm+8Ali6eBLD5pe7rahLMj0eiTrRbk
         7DicIlCeKA5pH3rIOuRqifjQY//Fbnii0yaqfcJmUd0KN9gy2zZnLISauR8enuyBHA/x
         tj7w==
X-Gm-Message-State: AD7BkJJpCeQlSFHljMyqgU7nOKNq5lZ0Fprcuvgy7qhy6XhdMB5c7t5jXeIZkN5yGJ+U8MmARqHN5IZ7LWMyGw==
X-Received: by 10.107.13.65 with SMTP id 62mr1538331ion.186.1458087417358;
 Tue, 15 Mar 2016 17:16:57 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Tue, 15 Mar 2016 17:16:57 -0700 (PDT)
X-Google-Sender-Auth: 2wG8TdNlngQb8anQiD_vnaQorT4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288929>

So I end up doing this manually when I notice, but I was wondering ig
maybe git could just have an option to "git am" and friends to
de-tabify the commit message.

It's particularly noticeable when people line things up using tabs
(for the kernel, it's often things like "cpu1 does X, cpu2 does Y"),
and then when you do "git log" it looks like a unholy mess, because
the 4-char indentation of the log message ends up causing those things
to not line up at all after all.

The natural thing to do would be to pass in a "tab size" parameter to
strbuf_stripspace(), and default it to 0 (for no change), but have
some way to let people say "expand tabs to spaces at 8-character
tab-stops" or similar (but let people use different tab-stops if they
want).

Do people hate that idea? I may not get around to it for a while (it's
the kernel merge window right now), but I can write the patch
eventually - I just wanted to do an RFC first.

                Linus
