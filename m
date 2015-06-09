From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/19] pull: support pull.ff config
Date: Tue, 09 Jun 2015 16:59:28 -0700
Message-ID: <xmqqa8w8whzz.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-11-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:59:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2TQe-0000YI-IB
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 01:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbbFIX7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 19:59:33 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34770 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbbFIX7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 19:59:31 -0400
Received: by igbhj9 with SMTP id hj9so24128694igb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xvMOyksUNn/kRAKjcIwp+zdxoxmK10Hf234eebRAW/Q=;
        b=REXzzvUixVMvarfUJViHoS/m5V4R3JI91Jd/G5ruadekFVThlWndsLKqaLLF4SaoDZ
         hjNua97DL9NEEus9ow+Qmp1jDndouhGhIKa/7uAT2Mads9mKkkMRrrwNIFUUWmSNMDo1
         f+BLxyWbs3mh6h28/0nC3f6Jgkkso+t6n6qMoP6J+7oQzMVRbn98NJxwQ3a4dFAVh5sI
         BOVtRH7p2m3CKCzWQyWhzCbf8ATuvEw+Su5bitlAKEkKbOaHrVBq/M72eETLN06ctuKK
         x8baE3N4kCjvIimibghig4hmv6xaMHx+W+ESXmupbY757oKjAgnKd7sbsM/jEsZ3xl7j
         4aSg==
X-Received: by 10.50.178.133 with SMTP id cy5mr23827951igc.5.1433894370762;
        Tue, 09 Jun 2015 16:59:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id p196sm4996413iop.15.2015.06.09.16.59.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 16:59:29 -0700 (PDT)
In-Reply-To: <1433314143-4478-11-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 3 Jun 2015 14:48:54 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271245>

Paul Tan <pyokagan@gmail.com> writes:

>     
>     * Yup, I did mean strcmp(value, "only")

I may be missing some backstory behind this comment; in the patch, I
instead see !strcmp(value, "only") and I think it makes sense.

> +	if (git_config_get_value("pull.ff", &value))
> +		return;
> +	switch (git_config_maybe_bool("pull.ff", value)) {
> +		case 0:
> +			strbuf_addstr(sb, "--no-ff");
> +			return;

Align switch and case at the same indent level; the body of switch
is overindented.

> +		case 1:
> +			strbuf_addstr(sb, "--ff");
> +			return;
> +	}
> +	if (!strcmp(value, "only")) {
> +		strbuf_addstr(sb, "--ff-only");
> +		return;
> +	}
