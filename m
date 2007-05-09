From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [PATCH] remove unnecessary loop
Date: Wed, 09 May 2007 09:03:38 +0800
Message-ID: <46411DEA.6060404@gmail.com>
References: <463FEC07.8080605@gmail.com> <4640015F.1080407@gmail.com> <20070508093902.GB9007@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb18030
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 09 03:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hladm-00049T-I0
	for gcvg-git@gmane.org; Wed, 09 May 2007 03:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbXEIBGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 21:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbXEIBGq
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 21:06:46 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:11871 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbXEIBGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 21:06:45 -0400
Received: by nz-out-0506.google.com with SMTP id o1so26742nzf
        for <git@vger.kernel.org>; Tue, 08 May 2007 18:06:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FdtdWK8KXbg0asPYU+5DL0um+dduE3peHm8z3ee2+Eb8ce8t/NhpOFUlyHpEAGpeZoXoD64kZtzUG23X2znXf2rUIBbpYQVmUNMsQ57qgZjFWaADtrIuqn4uUS+kSD2gHf58N90AumlMSOnUOU+H7VHSewu4lw7/B1lw8lRJnRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hfKzQBng7yDskvPNFsadJAKn7ziwDytPVQNTa1Wrn9AfhZqz9tDsb51QREhZdj9tt6cyrLLwl/P9p+rS7LHrQkRuls2fYSROuMkdDrCRbsVqAlsWFqxn1RmkAAf9IBjkztqAQqwZH3KQjgqCfNKSEbaPaSLcl5g+7wlJFftlxc4=
Received: by 10.114.155.1 with SMTP id c1mr2697264wae.1178672803939;
        Tue, 08 May 2007 18:06:43 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id z15sm2338023pod.2007.05.08.18.06.37;
        Tue, 08 May 2007 18:06:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <20070508093902.GB9007@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46649>

Jan Hudec wrote:
> On Tue, May 08, 2007 at 12:49:35 +0800, Liu Yubao wrote:
>> +#ifdef __CYGWIN__
>> +		/*
>> +		 * On cygwin, lstat("hello", &st) returns 0 when
>> +		 * "hello.exe" exists, so test with open() again.
>> +		 */
>> +		if (lstat(match, &st) && -1 != (fd = open(match, O_RDONLY))) {
>> +			struct dir_entry *ent;
>> +			close(fd);
>> +#else
>>  		if (!lstat(match, &st)) {
>>  			struct dir_entry *ent;
>> -
>> +#endif
> 
> You seem to have reversed the sense of the test.
> 
Sorry I made a mistake, Junio's suggestion is pretty clean, and
that test should be
		if (!lstat(match, &st) && -1 != (fd = open(match, O_RDONLY))) {

Yesterday I digged the Cygwin mail archive, I found it's a concession for windows
as you said in the previous message. I agree with you, just let it be.

Once more, I get the lesson: Windows is poor, sigh...
