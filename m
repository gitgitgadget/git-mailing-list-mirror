From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Thu, 07 May 2015 23:04:11 +0100
Message-ID: <554BE15B.3040303@diamand.org>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>	<1431019501-30807-3-git-send-email-luke@diamand.org>	<xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>	<554BBCBE.1020408@diamand.org>	<xmqqlhh0nny1.fsf@gitster.dls.corp.google.com>	<554BCE25.5070308@diamand.org>	<xmqqa8xgnlme.fsf@gitster.dls.corp.google.com> <xmqq3838nl5l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 00:04:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqTuW-0000yL-5j
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 00:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbbEGWEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 18:04:47 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35628 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbbEGWEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 18:04:46 -0400
Received: by pabtp1 with SMTP id tp1so51310680pab.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eHMt+CXlM6qfOZHqxPdiOdZ4aIXgaN5aZAgnuzOxrfs=;
        b=QBqihFv3byrHyr2ELzvs9i9USKiPqOVo6bQWzdA8CD7ickWbaKLoseprA7v6c9Fsth
         s2rNuKxmGrGl3bcWv7wEEcOfG9yq0G4VN707b110t8cipdEijOaKpOmtKAdOGuW750bq
         KTvZ1IjQpytMqMlx3v8cL8upKupJJfbDgzyLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eHMt+CXlM6qfOZHqxPdiOdZ4aIXgaN5aZAgnuzOxrfs=;
        b=hUTQNO96swWvNTIDk+K06ZQJBU6WcinS7f/qvdM26cg0/qQtYj6f9jJUR8r0WObYUw
         xVHk9eErPY0yVZ1wqaZVX5Oik3xipCYr/+V7Q1LfjarjpTpX5gEr6/oFvZSkZhLJs4LM
         9r09JZ7vH7mNCaDt/bArGwD7cLaAYLs5B5dwb4IkOzKEwAhcEaFciepcCbBFNJuI1FBB
         13Cw9IvSrQjNOpH3RogZR8/HMAPMeoWGArNCU7kJnIVuU5ypkyCK+QvifCvKOiyi+TRq
         aiHma33MM0CAvdR4CMjiUMLGUZra1F23I5zdk/VH52aos40HHjbXNKfTjS2rSyMMG4ZI
         hdDA==
X-Gm-Message-State: ALoCoQleqGZf+aNTavzIZndd9K5/o9nvlmDzuVlgzcpLywtB2O52rBXeAH7sbK2lmgh9qM4E8OEA
X-Received: by 10.68.161.99 with SMTP id xr3mr1191600pbb.47.1431036286135;
        Thu, 07 May 2015 15:04:46 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id l8sm3107205pdj.80.2015.05.07.15.04.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 15:04:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqq3838nl5l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268592>

On 07/05/15 22:16, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> i.e. the shell at the beginning of system sees "$customEditor"
> (including the double quotes) as a quoted variable, expand the
> environment variable as exported, and treat it as the path to
> the program.  Again untested but I think
>
> 	P4EDITOR="\"\$customEditor\"" &&

Or will this work?

-	P4EDITOR="$TRASH_DIRECTORY/ed.sh" &&
+	P4EDITOR="\"$TRASH_DIRECTORY/ed.sh\"" &&

I'm still a bit worried about what will happen to Windows users with 
this change though. I think the following avoids breaking Windows 
clients, but I'm not sure if it's the right way to go:

-	system([editor, template_file])
+       system(shlex.split(editor) + [template_file])

I've not tested it on anything other than Linux so far, so best not to 
merge yet!

Luke

>
> should do the work.
>
>> +		export customEditor P4EDITOR &&
>>   		git p4 submit &&
>>   		p4 changes //depot/... >wc &&
>>   		test_line_count = 5 wc
