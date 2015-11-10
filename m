From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 08/11] fetching submodules: respect `submodule.jobs`
 config option
Date: Tue, 10 Nov 2015 14:29:48 -0800
Message-ID: <CAGZ79kbqedWRDADChorvWhcmyjO4iZqt4WO8KSo917pxWgr4Rg@mail.gmail.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-9-git-send-email-sbeller@google.com>
	<56426DD1.6090904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 10 23:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwHQM-0006Hs-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 23:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbKJW3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 17:29:50 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33524 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbKJW3t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 17:29:49 -0500
Received: by ykdv3 with SMTP id v3so20537321ykd.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 14:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OtLWuWGQzMx2nA/iIjwB1muSN8hTm6lc9CZlVnI/E10=;
        b=ZkaaMWt30t4eg8gHGudKI23N9lML7EqckOf1Pxg4JVzE8zbQXhL2lq+h36RwKjccU6
         CxNflSnRlGwLdTSXZhpX40MeC1fKMTo42jWosqKVBQXB6HE1letXJE+DOHWT6fGROofl
         WhQMJFkwWGsXOfTijy0ZkKXIq5ltsY8YthXhJg1GMP3uBf1jCiiw9MEbZtpCwaSLYKQ2
         BOrywzYhM56dJp9BeHfYLPUAIlNqGFRhEcyv+gnWX1WBtJyzEZM8aSo/JKt9338hYMj4
         Z12JysrkHPvPKMKZko9DocLi7pDA6WSKUPV+q4paMW92eCixVCuyu5JqfNSXKCTK5c7V
         pFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OtLWuWGQzMx2nA/iIjwB1muSN8hTm6lc9CZlVnI/E10=;
        b=lXrzTUQIIiGtG0fFBQPJcj7f0fSKnE/QQqqiW/57xVN+L20/aZ/EH3XC1FVV48zfKd
         Tj1BT4PJVatcISZV3t1ZOgpHSPyY0NNLkrwMqmWDv0aIEFhRgDJbjxfPBT7p7uxEW4A4
         fEpfhK4saOWTy0ir9vOmDYx9l94NkBjwjvS0M1atu2JsWDl9D3jEqoWOos1wWf9Y6Ynb
         FICDA8BZTMrk0mEo+aSPKVNWdSt8DMgp2j6OcTV2VRot8/kV+jDMjosIfZ+M+R8zYPOq
         +sc0M9oj3v6QO5HFxO53JULL/IAQay6KYgtR7ordPQrUNbG534SvdJbAAuLGwciZTspr
         kw1g==
X-Gm-Message-State: ALoCoQk4oxSMeJIQeAsLJ2/oUIoq+LiI0UlEHjy3PCopD2quBlyG6uhKy2x9Bv/pDXMAZMeTcJGq
X-Received: by 10.13.214.19 with SMTP id y19mr5764089ywd.63.1447194588665;
 Tue, 10 Nov 2015 14:29:48 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Tue, 10 Nov 2015 14:29:48 -0800 (PST)
In-Reply-To: <56426DD1.6090904@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281137>

On Tue, Nov 10, 2015 at 2:21 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> +submodule.jobs::
>> +       This is used to determine how many submodules can be operated on in
>> +       parallel. Specifying a positive integer allows up to that number
>> +       of submodules being fetched in parallel. This is used in fetch
>> +       and clone operations only. A value of 0 will give some reasonable
>> +       configuration. It defaults to 1.
>> +
>
>
> Just curious (and sorry if this has already been discussed and I missed
> it, but the volume of your output is too much for my current git time
> budget ;-): While this config is for fetching only, do I recall correctly
> that you have plans to do submodule work tree updates in parallel too?
> If so, would it make sense to have different settings for fetching and
> updating?

TL;DR: checkout is serial, network-related stuff only will be using
submodule.jobs

In the next series (origin/sb/submodule-parallel-update) this is reused for
fetches, clones, so only the network stuff. The checkout (as all local
operations)
is still done serially, as then you don't run into problems in
parallel at the same time.
(checkouts may be parallelized but I haven't done that yet, and postpone that
until it has settled a bit more)
