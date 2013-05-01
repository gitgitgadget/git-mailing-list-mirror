From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Wed, 1 May 2013 09:18:41 +0700
Message-ID: <CACsJy8CZ8E-ASmo237rRbYR7pqoseo-NpU6jVrg6Rvd9qSY01w@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh>
 <7vehdsf19m.fsf@alter.siamese.dyndns.org> <CACsJy8B3PpzidvAHado=y3ZromzROidmHh_OW9ZCOoFegzmQ3Q@mail.gmail.com>
 <CALkWK0nnmzV0dcZ9avO9zDPhnQh9wkF7stA77cNycoXfecfUuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 04:19:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXMdj-0003Pt-KD
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 04:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934046Ab3EACTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 22:19:13 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59966 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933831Ab3EACTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 22:19:12 -0400
Received: by mail-oa0-f46.google.com with SMTP id k3so1117187oag.33
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 19:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+2Z3yITLncA0K9iilby/OW9QfzIzrvH/TnM8zCDLhbk=;
        b=KcZ7Z72EbJ7R9yGG8sygonglgrywnNuFJm8xUB7gXWZgrIoBtK2yvnZvWYqBaecjeM
         WTFfnGbXc5NyNgQ15RnkxYtrI9sTkfBZTaXlVX7KjwbwdC4zSwXdBhYLLNjyO4KCBB2z
         kiM8ozFp99hbYuZJ8rBMHJS9LkP9Zk/lsGdvaQb2fymc/XkCeH7hG5WuoR+22Sifl/AI
         3W5bV+Rov5N/L+Gq2/hsSxOBMSNqL2FNKlRiJLeZ1v0VTwQIqmKKXt8qecaXJiRs16+e
         cmtQMOLZWlcu0dUSlCgvyvr0a5K2UMMchfpqAT0f4oQ0VsaRT/oBOQ2r7iqrTHaHJsyz
         4p6Q==
X-Received: by 10.182.148.231 with SMTP id tv7mr228786obb.38.1367374751494;
 Tue, 30 Apr 2013 19:19:11 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 30 Apr 2013 19:18:41 -0700 (PDT)
In-Reply-To: <CALkWK0nnmzV0dcZ9avO9zDPhnQh9wkF7stA77cNycoXfecfUuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223065>

On Wed, May 1, 2013 at 12:15 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> We could put still ref aliases
>> into the same ref namespace, with lower precedence that actual refs,
>> so no new syntax required.
>
> Actually, ref-alises are the right way to solve the problem.
> Recursive symref peeling is a bad idea: I can't take my aliases with
> me, and they complicate unnecessarily.
>
> Any thoughts on how to implement it?  Should it go as deep as
> resolve_ref_unsafe()?

Depends on how you define ref alias. resolve_ref_unsafe allows you to
substitute one ref with another. Thomas was talking about substituting
part of extended sha-1 syntax (U -> @{u}) so it can't be done down
there. I still think get_sha1_with_context_1() is the right place.
Still not so sure how to handle when we have both alias "U" and
refs/heads/U.
--
Duy
