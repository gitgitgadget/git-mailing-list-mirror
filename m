From: Rys Sommefeldt <rys@pixeltards.com>
Subject: Re: [cgit PATCH] Close file descriptor on error in readfile()
Date: Sat, 07 Nov 2009 02:26:17 +0000
Message-ID: <4AF4DAC9.3020805@pixeltards.com>
References: <4AF4D4EC.1040806@pixeltards.com> <f488382f0911061822y7d0b52d5sa5cf4b199554312f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Sat Nov 07 03:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6b0X-0000Y2-2u
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 03:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbZKGC0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 21:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbZKGC0S
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 21:26:18 -0500
Received: from pixeltards.com ([64.22.109.241]:57512 "EHLO mail.pixeltards.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbZKGC0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 21:26:18 -0500
Received: by mail.pixeltards.com (Postfix, from userid 1009)
	id DF2EF1037C; Sat,  7 Nov 2009 02:26:23 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on pixeltards.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from [192.168.2.3] (87-194-178-245.bethere.co.uk [87.194.178.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.pixeltards.com (Postfix) with ESMTPSA id 8B7071035F;
	Sat,  7 Nov 2009 02:26:22 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <f488382f0911061822y7d0b52d5sa5cf4b199554312f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132351>

Steven Noonan wrote:
> The above change looks bogus. If fd == -1, you close() it anyway?
>   
Ah, of course, sorry.  I'll redo the patch.
>> +    if (fstat(fd, &st)) {
>> +        close(fd);
>>        return errno;
>> +    }
>>    if (!S_ISREG(st.st_mode))
>>        return EISDIR;
>>    *buf = xmalloc(st.st_size + 1);
>>    *size = read_in_full(fd, *buf, st.st_size);
>>    (*buf)[*size] = '\0';
>> +    close(fd);
>>    return (*size == st.st_size ? 0 : errno);
>> }
>> --
>> 1.6.5.2
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>     
> --
>   


__________ Information from ESET NOD32 Antivirus, version of virus signature database 4580 (20091106) __________

The message was checked by ESET NOD32 Antivirus.

http://www.eset.com
