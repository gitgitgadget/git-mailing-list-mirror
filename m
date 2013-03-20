From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] index-pack: always zero-initialize object_entry list
Date: Wed, 20 Mar 2013 15:14:22 -0400
Message-ID: <CAPig+cSqnXeqfYnAm1Nct6UF4DcpP2hxzCUeTytrNENvpuBk2A@mail.gmail.com>
References: <20130319102422.GB6341@sigill.intra.peff.net>
	<20130319105852.GA15182@sigill.intra.peff.net>
	<8738vr5rqh.fsf@pctrast.inf.ethz.ch>
	<20130319154353.GA10010@sigill.intra.peff.net>
	<20130319155244.GA16532@sigill.intra.peff.net>
	<20130319161722.GA17445@sigill.intra.peff.net>
	<CAPig+cQobu8GoqSNjVw8498e8D3vEJKU+UVUqkYbwypLyPTNhQ@mail.gmail.com>
	<20130320191327.GA31383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:14:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOTM-0005dI-2e
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab3CTTOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:14:25 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:55891 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757254Ab3CTTOY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:14:24 -0400
Received: by mail-la0-f42.google.com with SMTP id fe20so3664461lab.15
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Zkzq3TB8Fns/bxF/d5EWZaGqr6JT0sMDcW1Cgss0iGc=;
        b=PuelEHHpeONWe4Qs7H+jDx1uDRGmpw7Zj33nadb5EuheRek95bY+1rz4P4u9nr7kto
         zuCoFy+1T8TRIhTgAhvtkmKA2U+uLAawQGq+IHVBu7hOwLYvrTO0H/YdZE3/DghMllpO
         C9hPhm+ibanPvLNz4RM6W/gg+s9/CbLFjpCvq5wORcy1BShN8dYZG4Z6ASMHae/b77bn
         FfDlWDyDIVbkx3ve8wrHXeWAnIIvM5wG7iw+G07qLfygr7/quE+Bcw5VdONMg0bxZv6e
         azsKde7vC2cdSZLBaYGv6EsZqqST23EFBW6m0A5lxPSoDtEUOHrqRtwQnnhF4+hgfb3b
         Ok8Q==
X-Received: by 10.112.162.65 with SMTP id xy1mr9886710lbb.105.1363806862475;
 Wed, 20 Mar 2013 12:14:22 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Wed, 20 Mar 2013 12:14:22 -0700 (PDT)
In-Reply-To: <20130320191327.GA31383@sigill.intra.peff.net>
X-Google-Sender-Auth: GyJkgHQq5wJRCg6ZS_-HQc5q71A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218662>

On Wed, Mar 20, 2013 at 3:13 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 20, 2013 at 03:12:07PM -0400, Eric Sunshine wrote:
>
>> On Tue, Mar 19, 2013 at 12:17 PM, Jeff King <peff@peff.net> wrote:
>> > To ensure that all depths start at 0, that commit changed
>> > calls to xmalloc the object_entry list into calls to
>> > xcalloc.  However, it forgot that we grow the list with
>> > xrealloc later. These extra entries are used when we add an
>> > object from elsewhere pack to complete a thin pack. If we
>>
>> s/elsewhere pack/pack/
>
> I think it is supposed to be s/elsewhere pack/elsewhere/.

Sorry, yes.

-- ES
