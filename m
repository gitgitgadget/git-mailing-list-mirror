From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Wed, 07 Oct 2015 14:29:31 -0700
Message-ID: <xmqq612itlj8.fsf@gitster.mtv.corp.google.com>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
	<632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
	<20151006135101.GA11304@distanz.ch>
	<ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
	<xmqqfv1mvawu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZmon6xwDE2reSOjM87HfG_dqc6-Rk2KzxnePLAN=BiQw@mail.gmail.com>
	<xmqqh9m2tm8v.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYfcA4Atsx9zy+DNA_uhW-f91c5dLMGqhwSpEV7tPE5dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Tobias Klauser <tklauser@distanz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 23:29:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjwHK-00070h-Tb
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 23:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbbJGV3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 17:29:34 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33306 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbbJGV3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 17:29:34 -0400
Received: by pacex6 with SMTP id ex6so32233807pac.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PMbeZUNtv485JynKzo6lTMYTsCIT95HHy9v0DWKwZv8=;
        b=JQXjFudK2V50p2EdvI7w0cohaJ8BsOHqDuUYRDqDmS9LbCu7zodNEf8Kw65STUuL6W
         1VQqYBfsFNbb+uwNqMYBD0SneK8auXp3DhjYEr79bKhNqkBfNea3hpbA/dcSDmoGKjxm
         0WzhVDC8g6zBdRoCe8jy+PodmU51fZ3Nmecn9frzGFuIotLUADKQ2v6a2QmZlH0KmP5T
         DgHTyupBMRodjcjZLbvgcpGKSphZ7SD+nNTkZC1to+0V03R+uS3Meo7s/aJyszJjrH36
         aT3F21on+wvprCMaTDo5GsfMjjxgJ5LsL0Rt1HGM482M+GU5+3pBtVV4KufEQMfwo8JY
         3U/Q==
X-Received: by 10.66.102.74 with SMTP id fm10mr3412820pab.151.1444253373557;
        Wed, 07 Oct 2015 14:29:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id sl7sm41208700pbc.54.2015.10.07.14.29.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 14:29:32 -0700 (PDT)
In-Reply-To: <CAGZ79kYfcA4Atsx9zy+DNA_uhW-f91c5dLMGqhwSpEV7tPE5dA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 7 Oct 2015 14:24:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279201>

Stefan Beller <sbeller@google.com> writes:

>> By the way, it is not a very good comparison, though.  The patch in
>> the old thread deliberately attempted to discard a useful piece of
>> information.  The information the patch in this thread attempts to
>> discard is not so useful, as there currently is nobody that returns
>> an error in the codepath.
>
> Isn't that a bit picky? (old thread: the information is useful, but
> nobody uses it,
> this thread: information is useless, and nobody uses it)
>
> So the similarity is nobody is using the result, the difference is the
> usefulness of
> the information provided.

Exactly.  Why is it picky?

The amount of work in the existing code that is discarded is the
amount of work it will take when somebody wants to resurrect the
compuation of that useful information.  When you judge pros and cons
for a patch that discards existing code, you would need to take both
into account---the cost of carrying it and the future cost of having
to resurrect it.
