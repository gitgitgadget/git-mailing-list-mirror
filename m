From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] submodule--helper, module_clone: always operate on
 absolute paths
Date: Fri, 1 Apr 2016 16:09:40 -0400
Message-ID: <CAPig+cSDNLvBYLUc1VvPoS=dQX9P3YCCiZVHcZ91MqCHZpf_dg@mail.gmail.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
	<1459469849-9643-2-git-send-email-sbeller@google.com>
	<xmqq7fghi1ds.fsf@gitster.mtv.corp.google.com>
	<xmqq37r5i0tv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 22:09:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am5O6-00044t-66
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 22:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbcDAUJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 16:09:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33243 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcDAUJl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 16:09:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id o63so21795756ywe.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=RMAuQj2xpZ6F057pcdFob0yUZANbQmYaenKbISHdt5Y=;
        b=SLAgdG/ZEEZGLMnzC280jfr/UASOmvwAGf5HgfjV8uA82oBpVrzfUdMBYS29tbfNvD
         53W2DBP1baSgt2uh9f9+PtRy8zjaIoOWeGDNWqrKrCWn+CHAkt7r5O2uucUlApcPav2J
         Zw0T9wFch/nWjPgRkctTzKCC4Sa28ScwTrUq/0e6oo8AO2RwVJw234+m633pzzAmPUeX
         zBVlbwxcQk/eRlZif6uwAVJvz/cCuD8BruPg9CCk8Ma2QCoqQrGHW67Kj9Zs05g5Rd4P
         DsqREv5kSJyRXKS8q1qKw3MhCOrCDqWuYkrQIGOEF6pDURTHSbqccCuERdYh8AQLWdRG
         MWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RMAuQj2xpZ6F057pcdFob0yUZANbQmYaenKbISHdt5Y=;
        b=Ji7tvkGA/k07aQJeD7X3LG0w2J6bdWgDL4HAKuWvp8x/oyJaw1gEkmVbU2KRmSJuPL
         PU3gGwjA9i3tmlGjwysFgcd1d/6hRBlj1K8RR0PR0jE2wBzb0R/+4kYLzUNfeLS1vpo9
         QIckSuek1xrMGy+r5iMx+L46fl+2qWZKUhb0zVCG3EKtf95OK1CiFOjWsGFciw4OnIWB
         WDN9LiZYi6vaOf15UQi4BILtjtKJ+1a0YJbKo/jehpW64/7CV6+d2+FyxDBY9w2O07R9
         LtqiIslgPjsvR8SBa/I2M0i4McC2mrpP645cAPitrBsm/zj2z/9lLqNultAHfyGaL/qu
         giwA==
X-Gm-Message-State: AD7BkJIMmZL+5olwLD29WFpA18VhRnrptHF2sxM2Ad6Hp4x0HVftLN0mzqBDoizncjcH5nnBq98CnQ9WKSbtMw==
X-Received: by 10.159.37.234 with SMTP id 97mr2564248uaf.99.1459541380527;
 Fri, 01 Apr 2016 13:09:40 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 1 Apr 2016 13:09:40 -0700 (PDT)
In-Reply-To: <xmqq37r5i0tv.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: Lo1GzITYTUnguiQvTqIYZSzclVI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290579>

On Fri, Apr 1, 2016 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] submodule--helper: do not borrow absolute_path() result for too long
>
> absolute_path() is designed to allow its callers to take a brief
> peek of the result (typically, to be fed to functions like
> strbuf_add() and relative_path() as a parameter) without having to
> worry about freeing it, but the other side of the coin of that
> memory model is that the caller shouldn't rely too much on the
> result living forever--there may be a helper function the caller
> subsequently calls that makes its own call to absolute_path(),
> invalidating the earlier result.
>
> Use xstrdup() to make our own copy, and free(3) it when we are done.
> While at it, remove an unnecessary sm_gitdir_rel variable that was
> only used to as a parameter to call absolute_paht() and never used

s/absolute_paht/absolute_path/

> again.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
