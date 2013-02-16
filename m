From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] read_directory: avoid invoking exclude machinery on
 tracked files
Date: Sat, 16 Feb 2013 10:31:36 +0700
Message-ID: <CACsJy8BgDZCfWLZT4kNa+Qt5n7YZJ_wemh9gKbrtimbjcmj+sg@mail.gmail.com>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
 <7vd2w1wmdo.fsf@alter.siamese.dyndns.org> <CACsJy8A6oBjbaX=3iQcSxcwed28KLTk_tN+iuWDLsC512Z2V1Q@mail.gmail.com>
 <7vd2w1gyok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 04:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6YVt-0006Rn-GJ
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 04:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab3BPDcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 22:32:08 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:64843 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3BPDcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 22:32:07 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so4292626obc.34
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 19:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6FGhOjYPc3rWqO2GzF+ps/78AFLSbaVyMbcJV7M9QWs=;
        b=K9u5WVQkfa9PWPp4uFOUaq8IMqfdGtdohwLOztX8wBRSjZws6CPl+q5BhRHi+ok/wx
         QWAKorMjhIJcK9p6kIc44bS08CKaGtx5RpbEyYf+ALkBcTghUNHcOGhDLZQ1Tu4m2IAv
         DTGkwxSusbLe/Oo0vzUcoZIGYyXHcwwmkUIPFdgN2bhQL9IBMKCPqV3EA5ME4vWFTCo5
         0j5e9rdTwAvuE/LLn7G8oxLL4uliWysGI4rFjMJPJHqaGFum+Zvg3ZAqyF+N7pXU7r3N
         GqCZh+4kKTjCYTuYacomabGsjkTu/YaQV0Det2FGY+vNK7QOB+1vyMyJDPFrYt0EAaLY
         GN+A==
X-Received: by 10.182.12.39 with SMTP id v7mr3172306obb.47.1360985526838; Fri,
 15 Feb 2013 19:32:06 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Fri, 15 Feb 2013 19:31:36 -0800 (PST)
In-Reply-To: <7vd2w1gyok.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216370>

On Sat, Feb 16, 2013 at 2:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> If you consider read_directory_recursive alone, there is a regression.
>> The return value of r_d_r depends on path_handled/path_ignored. With
>> this patch, the return value will be different.
>
> That is exactly what was missing from the proposed log message, and
> made me ask "Do all the callers that reach this function in their
> callgraph, when they get path_ignored for a path in the index,
> behave as if the difference between path_ignored and path_handled
> does not matter?"

I'll add it the the log message. Although I'm thinking some
restructuring to separate tracked file handling from the rest may make
it clearer (and less error prone in future).
-- 
Duy
