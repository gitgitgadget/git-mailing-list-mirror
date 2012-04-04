From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick failed
Date: Wed, 04 Apr 2012 15:23:26 -0400
Message-ID: <4F7C9FAE.5050806@sohovfx.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com> <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com> <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com> <20120403144505.GE15589@burratino> <4F7B650C.9060800@sohovfx.com> <20120403210815.GB19858@burratino> <20120403211219.GC19858@burratino> <4F7B69FE.9010600@sohovfx.com> <20120403212650.GD19858@burratino> <4F7B839D.2020808@sohovfx.com> <20120404181148.GB16993@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 21:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFVnw-00067c-Lr
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 21:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663Ab2DDTXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 15:23:35 -0400
Received: from smtp01.beanfield.com ([76.9.193.170]:64736 "EHLO
	smtp01.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932645Ab2DDTXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 15:23:34 -0400
X-Spam-Status: No
X-beanfield-mta01-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta01-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta01-MailScanner: Found to be clean
X-beanfield-mta01-MailScanner-ID: 1SFVnj-000OtG-85
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta01.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1SFVnj-000OtG-85; Wed, 04 Apr 2012 15:23:27 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <20120404181148.GB16993@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194722>

On 04/04/2012 02:11 PM, Jonathan Nieder wrote:
> Do you mean we should get rid of CHERRY_PICK_HELP?
>   
No. I thought you meant that if "cherry-pick" runs into an error, it
should not leave behind a state (i.e. CHERRY_PICK_HEAD) when
CHERRY_PICK_HELP is defined. And I was arguing that defining
CHERRY_PICK_HELP shouldn't affect the behavior of "cherry-pick" at all.
So it shouldn't be trying to remove the state in the first place. The
cleanup responsibility should fall into caller of "cherry-pick". i.e.
"rebase -i"

Though I now think that my original patch description could be improved
to better reflect that.

And you also mention earlier that the patch is more of a symptom relief,
and that
> a more appropriate long-term fix would involve "git
> cherry-pick" noticing when a patch has resolved to nothing instead of
> leaving it to "git commit" to detect that.
And I was arguing that "cherry-pick" doesn't have to detect scenarios
where "commit" could fail. Since there could be other scenarios where
"commit" could fail and "cherry-pick" is already handling "commit"
failing, I think there's no need for "cherry-pick" to handle an empty
commit specifically.

So if the list or Junio thinks that the patch is the right thing to do,
I should improve on the patch description before we queue it.
