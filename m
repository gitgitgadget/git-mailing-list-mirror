From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] utf8.c: print warning about disabled iconv
Date: Tue, 9 Jun 2015 00:07:05 +0300
Message-ID: <20150608210705.GA22850@wheezy.local>
References: <1433624551-20730-1-git-send-email-max@max630.net>
 <xmqqfv62ch0v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:07:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z24Fx-0005Km-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 23:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbbFHVGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 17:06:49 -0400
Received: from p3plsmtpa09-09.prod.phx3.secureserver.net ([173.201.193.238]:41608
	"EHLO p3plsmtpa09-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751888AbbFHVGs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 17:06:48 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-09.prod.phx3.secureserver.net with 
	id dx6f1q00U5B68XE01x6luV; Mon, 08 Jun 2015 14:06:47 -0700
Content-Disposition: inline
In-Reply-To: <xmqqfv62ch0v.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271133>

Hi.

On Mon, Jun 08, 2015 at 09:16:16AM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:

>> This gives undesirable result that returned data or even
>> data written into repository is incorrect and user is not
>> aware about it.
> 
> I do not necessarily agree with that.  The user knows what
> s/he is doing, data written to or shown from the
> repository is correct as far as the user is concerned, and
> the user takes the full respoinsibility when compiling out
> certain features.

User, in theory, can be not the same person who builds, or
can be not aware that the case needs recoding. It actually
started when I compiled git without iconv support and got
about 10 failed tests, and only 2 of them mentioned i18n in
their name.

Compiling out other features is not exactly the same. If
user compiles out curl, for example, git will not be able to
push or fetch through http, but it is not going to pretend
to be working, it will fail visibly.

> I actually am OK if the user gets exactly the same warning between
> the two cases:
> 
>  - iconv failed to convert in the real reencode_string_len()
> 
>  - we compiled out iconv() and real conversion was asked.

Does 'exactly the same' mean the same text? Shouldn't it
describe the reason? I can see 2 possible failures in case
of real iconv: unknown or unsupported encoding and invalid
input. Wouldn't them better to be detailed in warning?

-- 
Max
