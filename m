From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] Allow custom "comment char"
Date: Wed, 16 Jan 2013 22:02:27 +0100
Message-ID: <50F71563.20406@web.de>
References: <1358275827-5244-1-git-send-email-ralf.thielow@gmail.com> <1358363928-16729-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 22:02:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tva8L-0001Fj-N4
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 22:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686Ab3APVCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 16:02:33 -0500
Received: from mout.web.de ([212.227.15.4]:58336 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756131Ab3APVCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 16:02:31 -0500
Received: from [192.168.178.41] ([91.3.180.56]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LlWGZ-1TKasl1CUR-00b7nm; Wed, 16 Jan 2013 22:02:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <1358363928-16729-1-git-send-email-ralf.thielow@gmail.com>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:UoCdUhjtaogRcisSAMK6A+XoVNea5RztKQ2m8rnnEEO
 siSrlXK4sHGLpI+DtZuMaCfd6HcFHBdZ2ewH6leZWiau7A4eEB
 WA2ExM1uA73lyj5YeIIcKoO/lYdfcfLzh8p4UHEeyQzy68Yjvo
 rdGfwUqRqwAi2oRjFNdAclui8W3Zl3Z/aNrOv1kdR9ciyHicaj
 ag3j6AUiufOL4W3gjY+Dw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213812>

Am 16.01.2013 20:18, schrieb Ralf Thielow:
> From: Junio C Hamano <gitster@pobox.com>
> 
> Some users do want to write a line that begin with a pound sign, #,
> in their commit log message.  Many tracking system recognise
> a token of #<bugid> form, for example.
> 
> The support we offer these use cases is not very friendly to the end
> users.  They have a choice between
> 
>  - Don't do it.  Avoid such a line by rewrapping or indenting; and
> 
>  - Use --cleanup=whitespace but remove all the hint lines we add.
> 
> Give them a way to set a custom comment char, e.g.
> 
>     $ git -c core.commentchar="%" commit
> 
> so that they do not have to do either of the two workarounds.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Junio, thanks for the code in your reply to the
> first version. It works very well and looks nice.
> I was also unhappy about this "\n%c\n" thing and
> pretty unsure with the code in "git-submodule.sh".

I can't see anything wrong with it (but didn't have the time to
test it). On my todo list (but *way* down) is the task to replace
the call to "git submodule summary --for-status ..." in
wt_status_print_submodule_summary() with a call to "git diff
--submodule" (and - at least in the long term - rip out the
--for-status option from the submodule script). Maybe now is a
good time for someone else to tackle that? (especially as the new
strbuf_commented_add*() functions should make that rather easy)
