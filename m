From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 2/2] submodule: Tolerate auto/safecrlf when adding .gitmodules
Date: Wed, 20 Jun 2012 14:06:43 -0400
Message-ID: <4FE21133.2030001@kitware.com>
References: <cover.1340202515.git.brad.king@kitware.com> <eebc8b3692f8fcb95cf75278f7c9f9982e8f2cd6.1340202515.git.brad.king@kitware.com> <4FE20DD3.6040607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:06:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPIs-0005cR-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab2FTSGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:06:50 -0400
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:49103 "HELO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756750Ab2FTSGu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2012 14:06:50 -0400
Received: from mail-yx0-f172.google.com ([209.85.213.172]) (using TLSv1) by na3sys009aob138.postini.com ([74.125.148.12]) with SMTP
	ID DSNKT+IROQuxfd9MqsHMgtb8Rft3peiDfdyj@postini.com; Wed, 20 Jun 2012 11:06:49 PDT
Received: by yenq13 with SMTP id q13so6654260yen.31
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 11:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=Tc6yhSCYXIy/4qB//m/aQiLH2o56CqV97D5tnSMe0lA=;
        b=EJOafRguwlCV4pzgzFmG71sJlhZNlXmlGQncoFa+xqebvSh2VF27tz9KJi8LJ+uYxJ
         Uj3JiARDmuz2yhbzG5RHjgeII7nLSjF11ZQ9ATl8bcXVhs+ZgewOGuZABtaaDrJU0MiU
         XtZFLYqv+I5EVRyYMEhcONYvYYMjuc31ZiiQcxcIgXv6UTv7vUiteU7sO4Yu0MYbZNkx
         Fc1G4u898SCL8GOkHC4m5+iCQgd+3KvdmXKpKleXpuevd3c5ErEKCBPlTflxvgadUATs
         80BNTAyfFTJw++x88sp31U3S3I4cI9G4UxcZ/UL4d+N5UKGuaKZH+dqKlKppq+T+Lffx
         Pr5Q==
Received: by 10.60.7.72 with SMTP id h8mr24827182oea.33.1340215605259;
        Wed, 20 Jun 2012 11:06:45 -0700 (PDT)
Received: from [192.168.1.236] (66-194-253-20.static.twtelecom.net. [66.194.253.20])
        by mx.google.com with ESMTPS id u5sm15621127obk.2.2012.06.20.11.06.43
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 11:06:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <4FE20DD3.6040607@web.de>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQlva64bwO5CGBVjSiQsenqiMj7ZLjO35q8TqKCY7VoAiMISRTQuS1rmor3WQm1hthjxsnEY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200311>

On 06/20/2012 01:52 PM, Jens Lehmann wrote:
> Am 20.06.2012 16:43, schrieb Brad King:
>> Temporarily disable 'core.safecrlf' to add '.gitmodules' so that
>> 'git add' does not reject the LF newlines we write to the file
>> even if both 'core.autocrlf' and 'core.safecrlf' are enabled.
>> This fixes known breakage tested in t7400-submodule-basic.
> 
> Hmm, I have no objections against the intention of the patch. But
> as I understand it this message will reoccur when the user e.g.
> edits the .gitmodules file later with any editor who just writes
> lfs and adds it.
> 
> I don't know terribly much about crlf support but maybe flagging
> the .gitmodules file in .gitattributes would be a better solution
> here? Opinions?

Once a user edits the file with an outside tool it is his/her
responsibility to add .gitattributes for the file.  In the reported
case Git is creating the file and already knows the crlf mode when
creating it.

I think Junio's proposal to teach "git config" to respect crlf
configuration is a more general solution.

-Brad
