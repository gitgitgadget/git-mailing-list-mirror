From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: Pluggable backends for refs,wip
Date: Fri, 8 Aug 2014 08:53:51 -0700
Message-ID: <CAL=YDWm5DAnjg_7Y+xUW3YVo5o83GFxdhMYTf4tAFPbRNEUX3w@mail.gmail.com>
References: <CAL=YDWk5C+bQS76_+jx1BSYSxecCxaS95RG181ecbJBLCNWLkQ@mail.gmail.com>
	<53E377AD.606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 08 17:53:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFmUP-0002NG-Ai
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 17:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363AbaHHPxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 11:53:53 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:44684 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbaHHPxw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 11:53:52 -0400
Received: by mail-vc0-f175.google.com with SMTP id ik5so8603000vcb.34
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N9g+ibiZ76KZBo+c2OZko9lHjO3HOEWdDKm2eLBci7g=;
        b=QQVN8k44mQolHpP0zYDT69632Re3mWfjN0HA9HPmtNygmfW6JNW04SAWummpu9zK+4
         Xlj8TeaOiVzotUXnC0qJq3J4NvYkL/zm94StO+rbBlsCIF3BCVsPPcDMp0qCzMQ/ZIpd
         BJANnLB9BWfmfx1ruAz73z1XBAW6De4LvgzQMgGVqx3jVRsCU79kQHvoPKwA+tJBt4B+
         ng1Zw7vLKmjkbs6nxJh7TekCAs5r1Y2IAZR2xCSPoKpqcoZhI/upwcAm+SLppsIG+WUb
         bUoV9YO6oPTQwhSAnlp80CFseqEURFpG+V7hEsvOLraEkzcAvFSeTgBHqgBAHXTPbCa1
         u29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N9g+ibiZ76KZBo+c2OZko9lHjO3HOEWdDKm2eLBci7g=;
        b=D1lVMWGzxeC/VHKb6rYYbERRaKr3XMfhP+AtfH1ShPmAi9sLLxvBYAcBwQM+pdeC2B
         yyw3vrCHTqj2RlXpt4CUE7si3Ul7KNJoQIlKxBa2wsZTXjdaL7VdRB5ladi3tJfX8EE2
         Ml2u3HZfKT6JBFlpQ9i6MEkdlBQLNJ+l4RVwUo6zBvFBqDaTFRLAermMkDjC7puYxK8X
         g84934xfVnOtVZUzhLSz1HdICJ4c2DsyLSb6uzpABqXUFAlsd6Z3VzoaHdDO9kiDWTU6
         z+9Zb6yVYulvKFcmzC5LT9t7kqtTcnNI9dvpzUp+d5urnZOUGkERQj/SuzGbrgUDqBT0
         cPLQ==
X-Gm-Message-State: ALoCoQmGTGQ4et7I3DN/HX5RuFuQU/dbMtJdeqvDYdyDeTMiNMU4DSfOTOEhk5vCLDcvgbKvlMRZ
X-Received: by 10.52.149.209 with SMTP id uc17mr1155832vdb.65.1407513231804;
 Fri, 08 Aug 2014 08:53:51 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Fri, 8 Aug 2014 08:53:51 -0700 (PDT)
In-Reply-To: <53E377AD.606@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255019>

On Thu, Aug 7, 2014 at 5:57 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/05/2014 02:40 PM, Ronnie Sahlberg wrote:
>> Please see
>> https://github.com/rsahlberg/git/tree/backend-struct-db-2
>> for an example of a pluggable backend for refs storage.
>>
>> This series contain changes to make it possible to add new backends
>> for handling/storage of refs and implements one new backend :
>> refs-be-be.c .
>>
>> This new backend offloads the actual refs handling to a small database
>> daemon with which ita talks via a very simple rpc protocol. That
>> daemon in turn then connects to the datastore and read/writes the
>> values to it.
>> [...]
>
> Ronnie,
>
> This is awesome!  Congratulations on your progress.
>
> I'm still on vacation and haven't yet looked at the code.  I will be
> back next week and hope to find time to check it out, and also to do
> some more review of the code that you have already submitted to git core.

Thanks!

>
>
> Have you thought about how to test alternate reference backends?  This
> will be very important to getting one or more of them accepted into git
> core (not to mention giving people confidence to actually *use* them!)

I have thought about it and also done some experiments.
For the initial git support, I think we first should try to get the
pluggable backend support
into git, and also the work to change the current files backend into a
built-in pluggable backend.

I.e. get everything in the
https://github.com/rsahlberg/git/tree/backend-struct-db-2
branch except the last three patches.
That brings us to a stage where we have pluggable backend support and
we have one backend, the files backend, that works just like today.

The last three patches in that series are then just confirmation that
the pluggable backend approach works and we can add that a little
later once we finish tests and other things.



For tests there are the issues with "git-clone" and "git-init"
requiring two additional arguments in order to set up and initialize a
repository to use the "database daemon backend".
Other future backends I would imagine would have similar needs.
The way I handle in the experiments I did was to use two new
environment variables GIT_INIT and GIT_CLONE that would default to
"git-clone" and "git-init" respectively
and then just override them with GIT_INIT="git-init
--db-repo-name=ROCKy --db-socket=/tmp/refsd.socket" when I wanted the
tests to initialize a "database backend" repository.
This required some updates to test-lib.sh and test-lib-functions.sh as
well as the tests themself to use ${GIT_INIT} instead of git-init
directly.

I am not sure what is the best approach here is and would love if you
could help out with this once we get the basic pluggable backend stuff
in.



>
> It seems to me that a few steps are needed:
>
> * Each backend would need a suite of backend-aware tests that verify
> proper operation *within* the backend.  These tests would mostly use
> low-level plumbing commands like update-refs to create/modify/delete
> references, and would be allowed to grub around in the filesystem, talk
> directly with the database, etc. to make sure that the commands have the
> correct effects.  For example, for the traditional filesystem backend,
> these tests would be the ones to check that creating a reference causes
> a file to spring into existence under $GIT_DIR/refs.

Yes.
Quite a few tests do muck around with the files directly. Some for
good reasons but I think there are a lot of cases where the tests do
it just out of convenience.

For this we will need to convert the tests that don't strictly need to
muck around with the files to use a backend agnostic method to do the
same checks.
For the tests that are truly testing the backend itself, such as a
hypothetical test to check that a symbolic link to a ref behaves as it
should, we will need a mechanism where we can conditionalize the tests
based on what is the current backend.
So lots of "if backend == database then skip this test"


>
> The tests for pack-refs, and all tests that care about the distinction
> between packed and loose refs, would become part of the backend-aware
> tests for the filesystem backend.
>
> All of the backend-aware tests should be run every time the test suite
> is run (provided, of course, that the correct prerequisites are
> available, and subject to being turned off manually).
>
> * The rest of the test suite has to be made backend-agnostic.  For
> example, such tests should *not* be allowed to look under $GIT_DIR for
> the existence/absence of loose reference files [1] but would rather have
> to inquire about references via git commands.
>
> * It should be possible for the developer to choose easily which
> reference backend to use when running the agnostic part of the test
> suite.  The chosen backend should be used to run *all* backend-agnostic
> tests.
>

Agree.
It would be great if we could work on this together.


> A database-backed backend might even want to be testable in two modes:
> one with the DB daemon running constantly, and one where the daemon is
> stopped and started between each pair of Git commands.
>
> So after the changes, a single run of the test suite should run the
> backend-aware tests for *all* known backends followed by the
> backend-agnostic tests for a single selected backend.

ACK.

>
> Michael
>
> [1] When I was working on my quagga-reference spike [2] I found that a
> lot of the test suite uses knowledge about how references and reflogs
> are stored by the filesystem backend and just grabs at the files rather
> than accessing the references using git commands.  It will take some
> work to clean this up.
>
> [2] http://thread.gmane.org/gmane.comp.version-control.git/243726
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
