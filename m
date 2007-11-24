From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/3] Move pathspec validation into interactive_add
Date: Sat, 24 Nov 2007 22:50:10 +0100
Message-ID: <4D81F973-8951-458A-958D-E24C826CA548@wincent.com>
References: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org> <1195908922-88023-1-git-send-email-win@wincent.com> <1195908922-88023-2-git-send-email-win@wincent.com> <1195908922-88023-3-git-send-email-win@wincent.com> <7vir3rqwts.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 22:50:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iw2tc-0000IW-Fm
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 22:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbXKXVuW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Nov 2007 16:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbXKXVuW
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 16:50:22 -0500
Received: from wincent.com ([72.3.236.74]:35023 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbXKXVuV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Nov 2007 16:50:21 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAOLoCdU019186;
	Sat, 24 Nov 2007 15:50:12 -0600
In-Reply-To: <7vir3rqwts.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65963>

El 24/11/2007, a las 20:15, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> Instead of throwing away the return status of pathspec_match() I am
>> keeping it, and any successful match breaks out of the loop early.
>
> Leaving it early before checking if all the given pathspecs are
> used defeats the whole "error-unmatch" business, doesn't it?

No, I probably didn't explain that clearly enough... If you look at =20
the patch, I break out of the *inner* loop the first time a particular =
=20
pattern matches. Then I move on to the next pattern, and any single =20
invalid pattern will be enough to provide the "error-unmatch" =20
indication.

>> Another issue is that simple shell shortcuts don't work, so somethin=
g
>> as simple as "git-add -i ." will report:
>>
>>  error: pathspec '.' did not match any file(s) known to git.
>
> The sample code snippet I sent you probably is not doing
> get_pathspec() before using the "pattern" thing.  And I suspect
> that ...
>
>> Likewise it's not possible to validate pathspecs like "\*.sh" either=
,
>
> ... may be related to that.


Ok, thanks for the pointer. Didn't know what the get_pathspec() =20
function was for, but will have a play with it.

Cheers,
Wincent
