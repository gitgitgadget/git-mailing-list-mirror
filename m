From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v5 1/7] add simple tests of consistency across rebase
 types
Date: Tue, 04 Jun 2013 08:15:39 +0200
Message-ID: <51AD860B.1070507@viscovery.net>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com> <1370292135-1236-1-git-send-email-martinvonz@gmail.com> <1370292135-1236-2-git-send-email-martinvonz@gmail.com> <7v1u8ide2b.fsf@alter.siamese.dyndns.org> <CANiSa6hGLKATn3uUJKoi4917R4qoiyRHHJWo-p8vFrCZsg5joQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 08:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjkX9-0003C6-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 08:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466Ab3FDGPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 02:15:47 -0400
Received: from so.liwest.at ([212.33.55.13]:12721 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab3FDGPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 02:15:46 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UjkWy-0000Lj-6z; Tue, 04 Jun 2013 08:15:40 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CF5021660F;
	Tue,  4 Jun 2013 08:15:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CANiSa6hGLKATn3uUJKoi4917R4qoiyRHHJWo-p8vFrCZsg5joQ@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226318>

Am 6/4/2013 7:14, schrieb Martin von Zweigbergk:
> On Mon, Jun 3, 2013 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +
>>> +# checks that the revisions in "$2" represent a linear range with the
>>> +# subjects in "$1"
>>> +test_linear_range () {
>>> +     ! { git log --format=%p "$2" | sane_grep " " ;} &&
>>
>> An interesting way to spell:
>>
>>     test $(git rev-list --merges "$2" | wc -l) = 0
> 
> Heh, true. I'll change that.

Then I think it would be even better written as

	revlist_merges=$(git rev-list --merges "$2") &&
	test -z "$revlist_merges"

so as not to ignore errors in the git invocation (and at least one less
fork()).

-- Hannes
