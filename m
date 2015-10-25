From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC] URL rewrite in .gitmodules
Date: Sun, 25 Oct 2015 16:12:23 +0100
Message-ID: <F01EF930-9787-44DD-A2E5-F5FBA029D3E7@gmail.com>
References: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com> <xmqqio618mxc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 16:12:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqMyF-0001GL-MI
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 16:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbbJYPM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 11:12:27 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38312 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbbJYPM0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2015 11:12:26 -0400
Received: by wicll6 with SMTP id ll6so84066423wic.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nQVlQ9mmYT0ZsiNvTs9b6APUraBOcOWljtHb7fRtAmU=;
        b=MrYk22tqGdWhF8aLrcynxfqiwisYgMAayYwAHJWAE77ejp4FdcXio5FYVLqJTR7K6T
         cJMbigDNtCZuNwq/qkKky/Mw+Os85nKlWBo8dkfOBLrHDPaJ7LufbuJ8yAreWp8hHH05
         Re1J4QNa/ItMIYcqfbQKj43NBGi6Rlx+waR60G2axAPNFxrIJvXVggr68Wj2801LhrhT
         FPHElxau+HrKIqY7MAoBPRDnYrPlqQK35STIHmiOnut92FRZNAlh7IvduoIPaIsadXJz
         PbMnM8xvnZ88tNZMZiGAILk3Zkk0dvBVaJywyBo+CFb76OLr3ZJ+mrkDKD4rllXHe8W+
         ZhAw==
X-Received: by 10.28.8.129 with SMTP id 123mr1459416wmi.25.1445785945628;
        Sun, 25 Oct 2015 08:12:25 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB6D4C.dip0.t-ipconnect.de. [93.219.109.76])
        by smtp.gmail.com with ESMTPSA id jt9sm18805055wjc.24.2015.10.25.08.12.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Oct 2015 08:12:24 -0700 (PDT)
In-Reply-To: <xmqqio618mxc.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280155>


On 20 Oct 2015, at 19:33, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> If not, what do you think about a patch that adds a "url" section
>> similar to the one in git config to a .gitmodules file?
>> 
>> Example:
>> ----------
>> [submodule "git"]
>> 	path = git
>>        url=git://github.com/larsxschneider/git.git
>> 
>> [url "mycompany.com"]
>>        insteadOf = outside.com
>> ----------
> 
> It is unclear to me if you are adding the last two (or three,
> counting the blank before) lines to your company's private fork of
> the opensource project, but if that is the case, then that would
> defeat your earlier desire:
> 
>> ... I also would prefer not to do this as I want to use the
>> very same hashes as defined by the "upstream" ...
> 
> wouldn't it?
The last three lines are added to my companies closed source Git repo. In this example the company repo references git://github.com/larsxschneider/git.git as submodule. This submodule in turn references another submodule with a URL "outside.com". This is the URL I want to rewrite. Do you think this could be useful to others as well?


> I do not think this topic is specific to use of submodules.  If you
> want to encourage your engineers to fetch from nearby mirrors you
> maintain, you would want a forest of url.mine.insteadof=theirs for
> the external repositories that matter to you specified by
> everybody's $HOME/.gitconfig, and one way to do so would be to have
> them use the configuration inclusion.  An item in your engineer
> orientation material could tell them to add
> 
> 	[include]
> 		path = /usr/local/etc/git/mycompany.urlrewrite
> 
> when they set up their "[user] name/email" in there.
> 
> And you can update /usr/local/etc/git/mycompany.urlrewrite as
> needed.
Oh nice, I didn't know about "include". However, as mentioned to Stefan in this thread, I fear that our engineers will miss that. I would prefer a solution that does not need any additional setup. Therefore the suggestion to add rewrites in the .gitmodules file.

Thanks,
Lars
