From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] t1500: avoid changing working directory outside of tests
Date: Tue, 17 May 2016 16:48:33 -0400
Message-ID: <CAPig+cTAgB6DXoEeJaDVy7_J7QiqNOm6AJqZTiSowO6_jqa8_w@mail.gmail.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
	<20160517193630.10379-4-sunshine@sunshineco.com>
	<xmqqeg90v2ss.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 22:48:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2luw-0000An-UF
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 22:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbcEQUsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 16:48:35 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34050 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbcEQUse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 16:48:34 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so5859850iof.1
        for <git@vger.kernel.org>; Tue, 17 May 2016 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Wd6sw5PPeb5IjxfAEXbIns47Ep187rHnj5VpBQgqLFs=;
        b=Rf9ZMZ3sJPqrWdIZSy8kFvClOka2ursdGVBaacdoT+/FOkGXjlEy74AH7S3fQg0ruS
         /yHARdZSmXzhrhHHS4os7OpEFyRt1aObpDOWrsWvQPsajzLXiFsPcTvWrAQuhdsbYgz/
         YxlJpmCADQ0XByAjzLmYg+sO21HWBjS+RUwOPuhUzOZKwGPFrKc7obA/N7DhoPq1GX9X
         DXyXoOZoi2QaD+14dTx/N9JipUZ3N9QUCQOAIbny/FJmrn8qLRdweKBZNfqHqaPjITK4
         CBf8GJODnvmnNcU5dm/DEntOr5jAc7H5rEZlyCDyqk95uJ42VNs5IIWUk0UtYywe8tGf
         Jgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Wd6sw5PPeb5IjxfAEXbIns47Ep187rHnj5VpBQgqLFs=;
        b=VsvyYjUyUctYNdKGb6jNWG/n92nIgrKNSh5n/gRu0rztNvo/hPbOuSY+8WQMnParX0
         boD5bQF2mJrpjm+g9rASp2Fxv1eBzZqcRZFQYa6QgiBPRcgOuDJYGMSvl9y3b4MtSEac
         bZo6EIbdmnBKKXl4b43cy25pkx5hjfzoNabO91R3gBLK7RV46pMqEILOrLL935G94RoV
         qRQVo4gdkTUncvX7ZZOG7YEDT7X8ObiypjYFiTjL0wBsNbnATInqPXLjAnEiE4yloJhL
         VVuojHXWz4FOOA3PlUuYBVEPedT0QyYYAdcwg/WhyyA0jp47FAAmxVtAXHvmRxQoAPRq
         jYQQ==
X-Gm-Message-State: AOPr4FUIpaueKFfkgrm4/bOlyY2MT4qEcHo49QGTx2Us7mxYfXRYonlWaM+Ldq5GH5ZKr7Td7EDNA1HSh47BiA==
X-Received: by 10.107.132.66 with SMTP id g63mr2838264iod.34.1463518113462;
 Tue, 17 May 2016 13:48:33 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Tue, 17 May 2016 13:48:33 -0700 (PDT)
In-Reply-To: <xmqqeg90v2ss.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: ZasreCskjkjU2ZRE7CXsw1SfzCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294913>

On Tue, May 17, 2016 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> +                     git ${dir:+-C "$dir"} rev-parse --$o >actual &&
>
> This is kosher POSIX, but I vaguely recall some shells had trouble
> with the SP between -C and "$dir" in the past.  Let's see if anybody
> screams; hopefully I am misremembering or buggy shells died out.

I also am bothered by a vague recollection of some issue (possibly
involving the internal space and lack of quotes around the entire
${...}), but couldn't remember nor find a reference to the specific
details. Perhaps someone reading the patch has a better memory than I.
