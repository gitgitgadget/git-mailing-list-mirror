From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [cgit PATCH] use Host: header to generate cgit_hosturl
Date: Tue, 2 Sep 2008 09:24:26 +0200
Message-ID: <8c5c35580809020024x564e8bc3o410cea6d4cd905@mail.gmail.com>
References: <20080901063033.GA21848@untitled>
	 <8c5c35580809011336v58b139acu5078cafd3440c786@mail.gmail.com>
	 <20080901230741.GA19984@hand.yhbt.net>
	 <8c5c35580809011614k6ec5a0e9tdfd5d3031c58b84@mail.gmail.com>
	 <20080901233033.GB19984@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:25:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQGb-0006J5-FB
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbYIBHY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 03:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYIBHY2
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:24:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:37190 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbYIBHY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:24:27 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1580246waf.23
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 00:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qrK6pN8G8uBvvCRBzb+EyVoqGWdPoFyg3O3ERgzHRNo=;
        b=cMyrrcobw5F8pwBrwL6cIw+fbSt5s2KCo9xIQDv01EJodR6+t68e6QQdsz2xjitgfL
         ru9XKpGsOvqKK+lySVOClxsXrUAxJ0oBUwtlKEqGt99D7X1vrlG+500rSUuBotcLdLxQ
         yYBDKeP3HDcGnSeXtE8D+Fq5Msx42PBZ1fupA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H/oj6aKo6/ZlPtCD14raDlci0av0BswX+4bfOFuxHbki7qB+cHjlvlwD1KWOJgVfnJ
         jjPjHQxMTZDlhHVk/0zNWVEkJ3mQtypmsnnOzsZkTkdaSwnkcYl7Yg1gegsdzFhFK3VN
         Kq92WLkiB8NXEBe9bmWoG1Ju7kY02OgfZfyE8=
Received: by 10.114.235.8 with SMTP id i8mr5928245wah.194.1220340266899;
        Tue, 02 Sep 2008 00:24:26 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Tue, 2 Sep 2008 00:24:26 -0700 (PDT)
In-Reply-To: <20080901233033.GB19984@hand.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94657>

On Tue, Sep 2, 2008 at 1:30 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Lars Hjemli <hjemli@gmail.com> wrote:
>> On Tue, Sep 2, 2008 at 1:07 AM, Eric Wong <normalperson@yhbt.net> wrote:
>> > Lars Hjemli <hjemli@gmail.com> wrote:
>> >> On Mon, Sep 1, 2008 at 8:30 AM, Eric Wong <normalperson@yhbt.net> wrote:
>> >> > So use the "Host" header if it is available and fall back to
>> >> > SERVER_NAME/SERVER_PORT for some clients that don't set
>> >> > HTTP_HOST.
>> >>
>> >> Maybe it would be better to use a new cgitrc parameter as fallback if
>> >> the client doesn't provide the "Host" header?
>> >
>> > That sounds a bit hackish to me since HTTP_HOST, SERVER_NAME and
>> > SERVER_PORT are all standardized.  Anyhow, it's your call :)
>>
>> I just figured that since SERVER_NAME/SERVER_PORT doesn't work in a
>> setup like the one you described, clients which doesn't provide the
>> "Host" header would never get a correct url. A default value for the
>> "Host" header in cgitrc would work around this issue.
>
> Actually, in my situation, the proxy server will unconditionally set a
> Host: header before sending the request to the lighttpd backend.  Header
> rewriting/injection is a common feature in HTTP aware proxies.


Ok, so if we assume that the "Host" header is only missing if the
client didn't specify it and there's no proxy involved, using
SERVER_NAME/SERVER_PORT as a fallback should be ok.

Thanks for the patch and explanation.

--
lh
