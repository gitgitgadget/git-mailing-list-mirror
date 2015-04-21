From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH V2 1/2] t9801: check git-p4's branch detection and client view together
Date: Tue, 21 Apr 2015 08:10:05 +0100
Message-ID: <B0C2FE2B-74B5-40CE-A818-B28E83AB4D2A@gmail.com>
References: <1429441009-17775-1-git-send-email-vitor.hda@gmail.com> <1429441009-17775-2-git-send-email-vitor.hda@gmail.com> <xmqqtwwbmk16.fsf@gitster.dls.corp.google.com> <48EB5BF2-166D-45F5-9573-0C9E16CAC2B9@gmail.com> <xmqq4moaju6c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 09:10:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkSJz-0004Zd-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 09:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbbDUHKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 03:10:11 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36314 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbbDUHKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 03:10:10 -0400
Received: by wizk4 with SMTP id k4so127410621wiz.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 00:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=zFinmyxUBt7dN0cwOj+h2VwFoy/V7KExZmljN+aKQOI=;
        b=H3I+iwVI3ARXw4Prcjzy+0oDOG9B6L4nIx4hZ9wO7CYe9dAdWgsg0HZh78MCzh3L5f
         6OWJFZGdRE6UfueWGyK6MKg56HGbyAWj3ftQek6eLj6eHxWrLw5MOE+60GcHpTqLFAtv
         Vcd+kkXbrvD0f+6gDUxCaVeeLZYfKrWBFGZeQfAqx2JfDBBq8JZED877xAldtUfaihHH
         ownGWlAUD62ngqcoaIx9K1AK4LMqIY97maMeaCKZsiV05vWwNDOa+wd3Y6PkAkOLKDSS
         gvplqI7kZRh5lCXBnsbVIs7h0GFyfXTLdGsLEVxE2xV5KpaQLTDgrB6/qrFjYtHJZwBg
         B81g==
X-Received: by 10.194.19.197 with SMTP id h5mr37475452wje.109.1429600209169;
        Tue, 21 Apr 2015 00:10:09 -0700 (PDT)
Received: from android-339016f4e6b2c83f.lan (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id ex5sm1723509wib.2.2015.04.21.00.10.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Apr 2015 00:10:08 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqq4moaju6c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267519>

On April 20, 2015 11:45:15 PM GMT+01:00, Junio C Hamano <gitster@pobox.com> wrote:
>Vitor Antunes <vitor.hda@gmail.com> writes:
>
>> On April 20, 2015 6:43:49 AM GMT+01:00, Junio C Hamano
><gitster@pobox.com> wrote:
>>>Vitor Antunes <vitor.hda@gmail.com> writes:
>>>
>>>> Add failing scenario where branch detection is enabled together
>with
>>>> use client view. In this specific scenario git-p4 will break when
>the
>>>> perforce client view removes part of the depot path.
>>>
>>>I somehow cannot parse "together with use client view", especially
>>>the word "use".  Is it "user client view" or something (I am not
>>>familiar with p4 lingo), or perhaps "use of client view"?
>>
>> I meant "spec" instead of "view". As in - -use-client-spec.
>>
>> In perforce you need to configure your workspace using a client
>specification.
>> One of the configured values is the client view, which maps
>files/folders in the
>> server to locations in your local workspace. What I'm trying to fix
>with these
>> patches is the ability of git-p4 to process the client view
>definition through
>> the use of "p4 where" to determine the correct location of the local
>files, such
>> that it is able to apply the necessary patches for submission to the
>perforce
>> server.
>>
>> While thinking about client views I completely forgot that the git-p4
>argument
>> that enables thos feature uses "spec" and not "view".
>
>So,... what's the conclusion?  Should the log message be written
>like this perhaps?
>
>    t9801: check git-p4's branch detection and client spec together
>    
>    Add failing scenario where branch detection is enabled together
>    with use of client spec.  In this specific scenario git-p4 will
>    break when the perforce client spec removes part of the depot
>    path.
>    
>    The test case also includes an extra sub-file mapping to enforce
>    robustness check on git-p4 implementation.
>    
>    Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
>    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Unfortunately at the moment I have limited computer access at
home. I will, obviously, update the descriptions as soon as
possible.
