From: Gary Wilson <gary.wilson@of-networks.co.uk>
Subject: Re: Unexpected empty directory removal
Date: Thu, 12 Apr 2012 20:11:07 +0100
Message-ID: <4F8728CB.2030201@of-networks.co.uk>
References: <4F870C04.9060304@of-networks.co.uk> <7vehrs6bt1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 21:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIPQM-0006TR-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 21:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933917Ab2DLTLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 15:11:14 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56022 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761417Ab2DLTLN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 15:11:13 -0400
Received: by eaaq12 with SMTP id q12so587078eaa.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 12:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=/PKQ3mHBw6FSL5Sx3LbLbMs8dnu6C63uGqnxbCLJ9To=;
        b=VKrGX4m1dLQaCsc4U17T6X6QqM/50Q5Wa/oJLTN6K9t/3fEwOY8zBvXWr1arvHLE1h
         w8+8m3FLJ3fq44wCs3iUyrVgi27wLE7Wab03Pl/5o1Ztj3MKT2eHX/hKuPIj9pcn/7JE
         Jlk5kqfSP3hi5kBhy98ZIRaKDCbHzoLwsCENl9BaJRbVQU1TAtV1QDMpJe+VJCRCeXF/
         QY5tulETMp7CD6kGKlre3BAUBmSf29pYj01IQEEU7VYvw9wDu7Hu0+RCXsYKrs+bpGru
         lxYLAGx6yt+Legrs/EXMd/m4f69BKdbW6eAjKATuALeq3Pgcsioq4tLwF4yC6Q/OpiZi
         VkoA==
Received: by 10.213.20.220 with SMTP id g28mr308610ebb.122.1334257872167;
        Thu, 12 Apr 2012 12:11:12 -0700 (PDT)
Received: from [192.168.1.31] (88.Red-88-7-10.staticIP.rima-tde.net. [88.7.10.88])
        by mx.google.com with ESMTPS id d54sm31763436eei.9.2012.04.12.12.11.09
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 12:11:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <7vehrs6bt1.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlfOf4mILJisRv0XsVGzlf+n3Hcx0x8Emsj2BZG5ioNW2AuK+V4Tg9yLrsNO47cOO5JDEi4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195356>

Thanks for the clarification and verification of that expected behaviour
Junio.  I shall keep this in mind.

Regards
Gary

On 12/04/12 19:32, Junio C Hamano wrote:
> Gary Wilson <gary.wilson@of-networks.co.uk> writes:
>
>> Use case to replicate:
>>
>> 1. Have path/files/a.file exists (and/or path/files/*) on client A and
>> client B
>> 2. Remove the physical files from the path/files/ directory on client A,
>> so that the directory is empty
>> 3. git commit
>> 4. git pull on client B
>> 5. On client A an empty path/files/ directory exists on client B it has
>> been removed, meaning path/files/ no longer exists.
>>
>> Is this the expected behaviour?
> As Git does not track directories at all, but merely uses directories as a
> means to instantiate files (which it tracks), when the last file is
> removed as the result of a merge in repository B, it notices that the
> directory is no longer needed to hold anything it cares about, and removes
> it.
>
> If you ran "git rm path/files/a.file" in repository A to remove the last
> file in the directory may also remove the now-empty directory (I do not
> remember offhand if it does), which is also expected.
>
