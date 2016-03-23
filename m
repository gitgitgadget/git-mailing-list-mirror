From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Wed, 23 Mar 2016 19:23:03 +0530
Message-ID: <CAFZEwPM1Ye34GJOfck89TX78BHKoiAVf-e=_TZasDV9u60VXGQ@mail.gmail.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
	<010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603221552100.4690@virtualbox>
	<CAFZEwPNg8-X5dsBbMfg5ni1XpOVekRd13y-zgwYJpX0fCwg3Ug@mail.gmail.com>
	<alpine.DEB.2.20.1603231220560.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 14:53:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aijDj-00063t-6y
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 14:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbcCWNxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 09:53:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33064 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbcCWNxE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 09:53:04 -0400
Received: by mail-yw0-f194.google.com with SMTP id a140so1829376ywe.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Nc25L+/CjOA73nok5agxLOBau7h4sgiDrYv2yj6vNew=;
        b=MYVnwozeh7RwLIS43NBroIY6ZCvmJ2hVnWMZNVNdcZKOa+gahEDuGO7mTGSx0jB3J+
         mo4N+mhKaf/dZFbEGrnQAJvnoHweEERAq7+yUImRm7wealtgxavFSGQtxes6RYIJ5Yp+
         jbah+8wDc6TPp7rhryuXOtwEEqZlmJgDNzwBrPjez3X0/YOfi11algHFMI076HwdgPXh
         IZ3yr9tyMEhBpCkdI3P8zdxtv0xZdQH0IjFfKWQQqhe11OPLrvqcye+ZdxlVgYZnmMk+
         qalDnbNHqqbwlDXA4bdv/TBgtqls8u6ogNEmnCZXHY920ZVlW9bvoQ2JFZGjpUQaq8Fp
         VBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Nc25L+/CjOA73nok5agxLOBau7h4sgiDrYv2yj6vNew=;
        b=BftodDgrR+yPbOA8kdxMwbueEwBigzUuZQC6qpjLnXjOp1iH+iivelgIomqCYpUZnF
         V4bzhL72jxU8tzrowjqVSwYZ0KDt9Mta5GJcgELJ2MUtSR5CLAGJ49gwwNB4SNr8pvZ4
         prYDeDl702r7wMQPURUhenLGyh85JfzazkbkfBWZiFVjVDRWc6K8MQcLodt/43GFFbxX
         s/zEsOsYqhGSSAUzr6rNNjVHsIWiiyjY1y6AKVGuHqn4kDxuTW9aIBiv+bDRhvKMXIK1
         kSVZht2/b5STpy26lpAhpUORz5SQuUQINjZHnHZFWul5OBmmiQDG/X1qDW5AB70z9K3q
         ql1A==
X-Gm-Message-State: AD7BkJLjdq+hWyGicbcA4D3DbW8cziKwa8BXnHSVtFXBG8hgyCa1SDvD5z4JD9awDf6MEkSmxV6xMv6KlGUA9Q==
X-Received: by 10.37.22.134 with SMTP id 128mr1482406ybw.7.1458741183936; Wed,
 23 Mar 2016 06:53:03 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 23 Mar 2016 06:53:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603231220560.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289656>

On Wed, Mar 23, 2016 at 4:52 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pranit,
>
> On Tue, 22 Mar 2016, Pranit Bauva wrote:
>
>> I did run the tests. They produce the same results as they did before.
>> To ease review I will next time include these the output of the tests
>> in the commented section.
>>
>> t6002-rev-list-bisect.sh : http://paste.ubuntu.com/15473728/
>> t6030-bisect-porcelain.sh : http://paste.ubuntu.com/15473734/
>> t6041-bisect-submodule.sh : http://paste.ubuntu.com/15473743/
>>
>> Is there any other test I would need to run?
>
> Oh, I just meant to point out that you need to make sure that the entire
> test suite passes after your patch series (and ideally, after every patch,
> that is at least what I frequently test before sending out patch series).

Up to now, I used to only run the tests of the concerned area of the
patch. Though from next time, I will take care to run the complete
test suite.
