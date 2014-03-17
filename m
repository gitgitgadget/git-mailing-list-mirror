From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 17 Mar 2014 20:52:00 +0100
Message-ID: <CA+SSzV2qpQ+O0Ee7hrv+TM-j03BAvC1s_qJqOnyoBtVbCgxjtw@mail.gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
	<1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
	<1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
	<xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:52:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPdZv-0004oK-9y
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbaCQTwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:52:01 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:34559 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaCQTwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:52:00 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so6146288oag.39
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qJa0wxMxFL28Cdm0hvP+i4f0jopOCGfd+y4lHfkBg0Y=;
        b=BGt+dbqvXvGk6SoDy02+bU/BDT+rZB9bSFTS9DI1PyYP4omgaFYi9N56vKQKwELtVj
         3qkepysZ+SjGt/7r5UsOhExwOPS3IlODy2DZabhQhVjwX8+6Taz+uKlYblcPX2bi29rZ
         azpyExJKRw9uHHVKoWHnjBmkN4p6es/inYl0GbfekETJNak6QVfyQlr+fO/0Rj7TU4Ax
         qWMF41x5QV7VBL7eeDNtiQ+5C+kAxvohFko+RbPdUlIBbUx9OIeG5jLHqdcobn3PcGji
         1eRMkZ1KK0j9G7tYVEPYN0bCr8lqOpfLkVl+0rc2Dw0QcH/SlLfxXcs4KqMcx/zBxxZf
         ilsA==
X-Received: by 10.60.37.99 with SMTP id x3mr3066939oej.61.1395085920083; Mon,
 17 Mar 2014 12:52:00 -0700 (PDT)
Received: by 10.76.94.143 with HTTP; Mon, 17 Mar 2014 12:52:00 -0700 (PDT)
In-Reply-To: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244275>

On Mon, Mar 17, 2014 at 7:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Benoit Pierre <benoit.pierre@gmail.com> writes:
>
>> +test_expect_failure 'edit hunk "commit -p -m message"' '
>> +     test_when_finished "rm -f editor_was_started" &&
>
> Not just "when finished", run "rm -f" here to make sure that the
> file does not exist.  Later other people may add new tests before
> this test piece and affect the state of your throw-away working
> tree, and you would want to protect yourself from their changes.
>
>> +     echo more >>file &&
>> +     echo e | env GIT_EDITOR="touch editor_was_started" git commit -p -m commit2 file &&
>
> Avoid "touch" unless you are interested in the timestamp to be
> updated.  Use ": >editor_was_started" or something like that when
> you are only interested in "it was not there, now it is".
>
> The same comment applies to the next one.

Isn't the point of using "when finished" to have each test leave the
tree clean after execution, to avoid "bleeding" onto the next test(s)?
Instead of having each test clean after the previous test(s). It seems
to me using both is kind of redundant, no?

-- 
A: Because it destroys the flow of conversation.
Q: Why is top posting dumb?
