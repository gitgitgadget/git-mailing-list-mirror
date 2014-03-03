From: Ilya Bobyr <ilya.bobir@gmail.com>
Subject: Re: [PATCH 1/2] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon, 03 Mar 2014 15:50:19 -0800
Message-ID: <5315153B.5030809@gmail.com>
References: <CAPig+cRnfDta9FofgH2jSdivzKvJiHwnzPZ5PoO4UTpWQLSH4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:50:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKccx-0005h3-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbaCCXu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:50:27 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:60301 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbaCCXu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:50:26 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so4344774pdi.35
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 15:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+OhJHc3Q17dM3fh3izzVwj0a3iHfGE5Jzu+NVbo6cZs=;
        b=NmqdkhUxoVO50pZI2Z3QHMoDzNRDfnyUs3v1L3hTMpMkuYPl38lTV0t2ZBcj2+/w0p
         IG8t2V6DqyaNN3khKYm79rkuRf8UZ4AYytbdGsYdXt8LLsUE/ZeG/aQ0AR8F4D7vNSra
         E0OSdT3LLOUVjQgM/HQNDN1CqwK1bKgYeWHRKXGZ4KlJguwiXLwna3IpNtb/aoNSA32q
         OPb2hyO2Wr/lfDUKl94FBcNfiOb5Ywwk3/8dAtXIfKIqhKBmI1XUY6q5T++ZUjG7cl7n
         Au7/3ONSebp0sewrqng/3jMJ2L0plvBTrPDu5kXkbrgZg2yPO23HYCkiQ9XbLsN1FkAr
         8bZw==
X-Received: by 10.68.133.138 with SMTP id pc10mr22297030pbb.98.1393890626326;
        Mon, 03 Mar 2014 15:50:26 -0800 (PST)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id vb7sm24525893pbc.13.2014.03.03.15.50.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2014 15:50:25 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Thunderbird/27.0
In-Reply-To: <CAPig+cRnfDta9FofgH2jSdivzKvJiHwnzPZ5PoO4UTpWQLSH4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243315>

On 3/3/2014 3:18 PM, Eric Sunshine wrote:
> On Mon, Mar 3, 2014 at 6:12 PM, Ilya Bobyr <ilya.bobir@gmail.com> wrote:
>> On 3/3/2014 2:59 PM, Eric Sunshine wrote:
>>> On Mon, Mar 3, 2014 at 5:24 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>>>> We used to show "(missing )" next to tests skipped because they are
>>>> specified in GIT_SKIP_TESTS.  Use "(matched by GIT_SKIP_TESTS)" instead.
>>> Bikeshedding: That's pretty verbose. Perhaps just say "(excluded)"?
>>
>> The next patch adds another reason for the test to be skipped, so it seems
>> reasonable to say why exactly.
>> The patch actually makes it say "matched GIT_SKIP_TESTS".
>> It looks OK on the console.
> Still just bikeshedding:
>
> That new message in patch #2 says "not in GIT_TEST_ONLY", but isn't
> "(excluded)" also applicable to that case? Is it important to be able
> to distinguish between the two "excluded" reasons?
>
> (No more bikeshedding for me.)

Makes sense.  I guess it is unlikely you would want to use both include 
and exclude filters in one run.
On the other hand it seems nice to see the reason why it was skipped.

Here are both options for comparison.  "Longer":

     $ GIT_SKIP_TESTS='t0000.[236789] t0001.??' ./t0001-init.sh
     ok 1 - plain
     ok 2 # skip plain nested in bare (matched GIT_SKIP_TESTS)
     ok 3 # skip plain through aliased command, outside any git repo 
(matched GIT_SKIP_TESTS)
     not ok 4 - plain nested through aliased command # TODO known breakage
     not ok 5 - plain nested in bare through aliased command # TODO 
known breakage
     ok 6 # skip plain with GIT_WORK_TREE (matched GIT_SKIP_TESTS)

and changed to "excluded":

     $ GIT_SKIP_TESTS='t0000.[236789] t0001.??' ./t0001-init.sh
     ok 1 - plain
     ok 2 # skip plain nested in bare (excluded)
     ok 3 # skip plain through aliased command, outside any git repo 
(excluded)
     not ok 4 - plain nested through aliased command # TODO known breakage
     not ok 5 - plain nested in bare through aliased command # TODO 
known breakage
     ok 6 # skip plain with GIT_WORK_TREE (excluded)

P.S. It seems that now the whole interface may change :)
