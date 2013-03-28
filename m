From: John Koleszar <jkoleszar@google.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 28 Mar 2013 08:54:35 -0700
Message-ID: <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com>
References: <1364446721-13351-1-git-send-email-jkoleszar@google.com>
	<7v38vfy48e.fsf@alter.siamese.dyndns.org>
	<CAAvHm8NAqVHLz1wjNN-3ocpYzWfO-PDo0PAJ6pZO7KrMkhJ6Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:55:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFAP-0000EM-AD
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324Ab3C1Pyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 11:54:37 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:52865 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab3C1Pyg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 11:54:36 -0400
Received: by mail-wi0-f173.google.com with SMTP id ez12so3455335wid.12
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=THIGJue3CDUYz5Jbr6YVjgSiwQ7n54HciGQKtE+8ySc=;
        b=evSECfyJSr+EwYHWZfuvgPOYnN0FoESu35utSf7hDnlhEDRWelNdzsSu8Yc3+9Yu3Y
         ++PczFrqvIIe9bAVl84oKhweT8F6ED4jW1+2AHmGlP9olEAQbEF1rus1rhP67TGxu9S9
         CRC6e4PV9rG2RESgRAu3FIdWE4bVgFe2GwIBt+q+ANAAiZSTzA3Bs1Wi0lDIJDDeGdg9
         /hMGoFqdttpwY73SX6DIZLWfIlDA2qUlZDDQ0TQXgdo6o/vW9nf2EE3ZWTjxNBoVjDp1
         6wogCuyf+jXuQI0L5orGo0+Jz38dSpKcltN+LZaB/RDqUnYNUeKaZcyIl1Jh0krVTrNL
         1xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=THIGJue3CDUYz5Jbr6YVjgSiwQ7n54HciGQKtE+8ySc=;
        b=UMZP50/kOiNUcGIBWyN+5JNO/YFADMAp+TDvQXDj7qUX9swfkWgdg3ddXvBGU9zkbE
         9kjkS53V8DBzYf9thusMPxLl1Z87TVzB7Nb9896F7Ew/Q+GLdec7KldYWRDeyMJLo97O
         NvJO6QUjxSyRUXllLyxaWRs1muZnqInc60qzIHaIJQDUPXBzj1S/gvu3kX3Uh61i8Zg9
         icrFkGBERXB/FJuL+klArYuK6k7cOwqilC12Vfg07J5HETQNR19yciReaarJReb3i4Fz
         FXsqKmUMfLqVVRRDhYEyFtbVITUsxsKowRNo5dwz/LRfZmizLEJXp8pnbrpvL2kzWcAM
         phzA==
X-Received: by 10.180.90.18 with SMTP id bs18mr17212288wib.31.1364486075187;
 Thu, 28 Mar 2013 08:54:35 -0700 (PDT)
Received: by 10.194.25.1 with HTTP; Thu, 28 Mar 2013 08:54:35 -0700 (PDT)
In-Reply-To: <CAAvHm8NAqVHLz1wjNN-3ocpYzWfO-PDo0PAJ6pZO7KrMkhJ6Jw@mail.gmail.com>
X-Gm-Message-State: ALoCoQnDRMjgtx3YnUY++NZhRPfpLR98ULevKmvFK2H2W+AkBvPTx3UufVsysebki/CRmDSvOknHk6tlWgXQdcsiF1Rz2HKB0Bl9pimWOjY5SG4nkk1xm2bB1hI8MpRiaUtztz9E0FAYk6Si0dqHyzQkySqMHqr0MPLWD3gBORXPtS8rYQAUF5BFkuuec7vBdBcSquo2fQS/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219415>

On Thu, Mar 28, 2013 at 8:52 AM, John Koleszar <jkoleszar@google.com> wrote:
> On Thu, Mar 28, 2013 at 7:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> John Koleszar <jkoleszar@google.com> writes:
>>
>> > diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
>> > index b5d7fbc..5a19d61 100755
>> > --- a/t/t5561-http-backend.sh
>> > +++ b/t/t5561-http-backend.sh
>> > @@ -134,6 +134,10 @@ POST /smart/repo.git/git-receive-pack HTTP/1.1 200
>> > -
>> >  ###
>> >  GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
>> >  POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
>> > +
>> > +###  namespace test
>> > +###
>> > +GET  /smart_namespace/repo.git/info/refs HTTP/1.1 200
>> >  EOF
>> >  test_expect_success 'server request log matches test results' '
>> >       sed -e "
>> > diff --git a/t/t556x_common b/t/t556x_common
>> > index 82926cf..cb9eb9d 100755
>> > --- a/t/t556x_common
>> > +++ b/t/t556x_common
>> > @@ -120,3 +120,19 @@ test_expect_success 'http.receivepack false' '
>> >       GET info/refs?service=git-receive-pack "403 Forbidden" &&
>> >       POST git-receive-pack 0000 "403 Forbidden"
>> >  '
>> > +test_expect_success 'backend respects namespaces' '
>> > +     log_div "namespace test"
>> > +     config http.uploadpack true &&
>> > +     config http.getanyfile true &&
>> > +
>> > +     GIT_NAMESPACE=ns && export GIT_NAMESPACE &&
>>
>> When other people want to enhance this test suite later, their tests
>> may not want the namespace contaminated with the environment
>> variable.  You would need to enclose from here to the end inside a
>> subshell or something.
>>
>
> Ok. I'm not familiar with the test infrastructure, I had guessed that these
> were already running inside a subshell. I'll make this explicit.
>
>>
>> > +     git push public master:master &&
>> > +     (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
>> > +             git for-each-ref | grep /$GIT_NAMESPACE/ >/dev/null
>> > +     ) &&
>> > +
>> > +     git ls-remote public >exp &&
>> > +     curl "$HTTPD_URL/smart_namespace/repo.git/info/refs" >act &&
>>
>> Spell out "expect" and "actual".
>>
>
> The exiting tests are using exp and act for this. No objection if you want
> me to spell it out here, but having two different files for this may be
> confusing.
>
>>
>> For some unknwon reason, I am getting an HTTPD_URL at this point,
>> causing it to fail with:
>>
>>     curl: (3) <url> malformed
>>
>
> Ah, my fault. I only ran t5561-http-backend.sh. Will fix.
>
>> > +     test_cmp exp act &&
>> > +     (grep /ns/ exp && false || true)
>>
>> What does that last line even mean?  Both
>>
>>         false && false || true
>>         true && false || true
>>
>> will yield true.  Leftover from your debugging session?
>
>
> Facepalm. The intent here is to invert the grep, to make sure that the /ns/
> does not appear in the output. No idea why I wrote it that way. Will fix.
>
