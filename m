From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 12 Dec 2008 17:45:34 +0100
Message-ID: <4942952E.1060706@viscovery.net>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>	 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>	 <alpine.LNX.1.00.0812061238260.19665@iabervon.org>	 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>	 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>	 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>	 <alpine.LNX.1.00.0812081223140.19665@iabervon.org>	 <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>	 <alpine.LNX.1.00.0812111520490.19665@iabervon.org>	 <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0812120813m2949e36ar7905d5688b8f6ecb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 17:47:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBBAQ-0002GC-6W
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 17:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbYLLQpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 11:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757570AbYLLQpq
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 11:45:46 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58245 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757545AbYLLQpp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 11:45:45 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LBB8x-0007kN-1O; Fri, 12 Dec 2008 17:45:35 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BC46C6EF; Fri, 12 Dec 2008 17:45:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <fcaeb9bf0812120813m2949e36ar7905d5688b8f6ecb@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102915>

Nguyen Thai Ngoc Duy schrieb:
> On 12/12/08, Junio C Hamano <gitster@pobox.com> wrote:
>>  So "git grep -e frotz Documentation/", whether you only check out
>>  Documentation or the whole tree, should grep only in Documentation area,
>>  and "git grep -e frotz" should grep in the whole tree, even if you happen
>>  to have a sparse checkout.  By definition, a sparse checkout has no
>>  modifications outside the checkout area, so whenever grep wants to look
>>  for strings outside the checkout area it should pretend as if the same
>>  content as what the index records is in the work tree.  This is consistent
>>  with the way how "git diff" in a sparsely checked out work tree should
>>  behave.
> 
> Assume someone is using sparse checkout with KDE git repository. They
> sparse-checkout kdeutils module and do "git grep -e foo". I would
> expect that the command only searches in kdeutils only (and is the
> current behavior).

But what if the same persion notices a #define in a kdeutils header file
and want's to know whether it is unused in order to remove it:

    $ git grep FOO
    kdeutils/foo.h:#define FOO bar

Conclusion from this output: "It's only defined, but not used anywhere."
But this conclusion is not necessarily correct because FOO could be used
outside kdeutils.

So, no, "git grep" should disregard the checkout area.

-- Hannes
