From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Wed, 13 May 2015 07:01:22 -0700
Message-ID: <xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 16:01:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsXE8-0000oF-FF
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 16:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934355AbbEMOB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 10:01:27 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36053 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933065AbbEMOB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 10:01:26 -0400
Received: by iepk2 with SMTP id k2so31278862iep.3
        for <git@vger.kernel.org>; Wed, 13 May 2015 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Y3wcEYMJNanvBANRMWfFRx3W937htH5axjCf55FqS7Q=;
        b=V98PYaIwD3VUR89PQNRkL8Zn0y/9+X9qhVWXWwspd7NGrjwllJYbL+7V9Hd9A8wPNq
         61GhfXnO2XIkZevF7cNWhSDgOYbsoG1S41IzIjXYk62eqNLVFcjAO+uiHZhoVqO9cS5D
         apRekU/pndD6dUvSLCGOQ88vLxRo+3t+rOf6rwmc5SQNMM47bruQ8zhks93zfqyyr/pm
         9FVFb4knuRD9Y+j5O3E93uEJg7mUIKDnRLEBSG4gWo0Fy2hKqqPgsBoUnIgS+TIQteRv
         Q1f6xIpAX8hOPu4wsI18pSIGa+8ZlupXv5JaXj3k5M1rQJtlQoJS/g0t61/I9Og8uqsF
         7pWw==
X-Received: by 10.50.62.148 with SMTP id y20mr28285269igr.17.1431525685806;
        Wed, 13 May 2015 07:01:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id f7sm3636931igq.7.2015.05.13.07.01.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 07:01:23 -0700 (PDT)
In-Reply-To: <1431508136-15313-2-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 13 May 2015 17:08:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268983>

Paul Tan <pyokagan@gmail.com> writes:

> Many tests in t5520 used the following to test the contents of files:
>
> 	test `cat file` = expected
>
> or
>
> 	test $(cat file) = expected
>
> These 2 forms, however, will be affected by field splitting and,
> depending on the value of $IFS, may be split into multiple arguments,
> making the test fail in mysterious ways.
>
> Replace the above 2 forms with:
>
> 	verbose test "$(cat file)" = expected

Quoting is very much a good idea, but I am not enthused by the
vision of having to write verbose everywhere in our script.

After seeing a script fail, you can run it again with -i -x options;
wouldn't it be sufficient?
