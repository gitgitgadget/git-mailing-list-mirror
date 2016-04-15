From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 0/2] implement better chunk heuristics
Date: Fri, 15 Apr 2016 10:10:31 -0700
Message-ID: <CAGZ79kZs33sJj+DPSS4FPoJTLqbCLpvSe_h9UUQM-dBe=8ExKw@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
	<CAGZ79kbCHA3L6mUfYn6OfVXLDEyhv70PwxXo-YHP_QZXXAB8ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:10:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar7GV-0004oG-8Q
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbcDORKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 13:10:35 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34058 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbcDORKc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 13:10:32 -0400
Received: by mail-io0-f176.google.com with SMTP id 2so141000791ioy.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ULXucHFULTDlrlEaOvUJ4CtohO8g7bgJjdui6p4Rk3E=;
        b=MDds1u2KhQ6XDPTgUKqwomkjW5yNGnDOFVsniFX4MARm0ymmm/VI3Wr9YRG+5ZCrh8
         X2mreBeLwq360qDL8QSfNhLuIv4My++bRSyFB+PW0RpWmiE1xk45sbg2S6yl4BpvERoE
         Gk70X8EkYlyaq+lkjCA5RJfOTDPkhZrtGC0wg6AEisWmwVL+93AbVzZLe7lbTQq2GkuO
         IQBRp6niQwP/61Jwq8GYObyBOyti7Akjqtj2CWC4JzByYl4KVyxsgf7UOVoUwKl/Uqoj
         PNbIsLmFLTrIs1pSXK3KVK+Ry8RsA6FRZzHLkbJkMlQmaSwmoapDwUEZOwjAJInZX4F8
         5BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ULXucHFULTDlrlEaOvUJ4CtohO8g7bgJjdui6p4Rk3E=;
        b=GH2dNKdru+TLvHUd5+265PleD5rYp7Cjbx0S18DirMeXk8DoC3q4aX8rZ5BY+LXBmS
         QYPS7ux3qfNTQkBjNc9oVJZm8mc4mF1E/sCOeIZNKTRuKtALmdZQYZijBsZyy17FkSDc
         Nh8E5MHWubui7Vz6L1GQKCB8HjS5OF7YBz0/EyTCzcCBSxVjMy+BWc0vjzQg2Cy0PP29
         cmWjidg8yZhc++pS0tvrupxBuqIYjBDJYdlhW1VthWr6+V/5jNNY670EefFC8FoFc2rh
         L4JLybMl1w4OPqTTWTwCxrs51dCIC+iHf5vVIcLhzgosrzJOZu7iXtijl/yGfaRsy9fT
         dceg==
X-Gm-Message-State: AOPr4FVbyYMqTov21oXjCN2qK+qcoEmmZgnKq6Qn5pkiuJIXkCZRFNp1QmZtbjpGHp9cxUXrWBmf7vRhvjqmDWF7
X-Received: by 10.107.161.68 with SMTP id k65mr27113261ioe.110.1460740231414;
 Fri, 15 Apr 2016 10:10:31 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 10:10:31 -0700 (PDT)
In-Reply-To: <CAGZ79kbCHA3L6mUfYn6OfVXLDEyhv70PwxXo-YHP_QZXXAB8ig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291622>

On Fri, Apr 15, 2016 at 10:02 AM, Stefan Beller <sbeller@google.com> wrote:
>> @@ -458,11 +458,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>                          * the group.
>>                          */
>>                         while (ixs > 0 && xdl_hash_and_recmatch(recs, ixs - 1, ix - 1, flags)) {
>> +                               emptylines += is_emptyline(recs[ix - 1]->ptr);
>> +
>>                                 rchg[--ixs] = 1;
>>                                 rchg[--ix] = 0;
>>
>> -                               has_emptyline |=
>> -                                       starts_with_emptyline(recs[ix]->ptr);
>
> How is this fixing the segfault bug?
> From my understanding ix should have the same value here as ix-1 above.
>
>>                                 /*
>>                                  * This change might have joined two change groups,
>>                                  * so we try to take this scenario in account by moving
>> @@ -492,9 +492,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>                                 rchg[ixs++] = 0;
>>                                 rchg[ix++] = 1;
>>
>> -                               has_emptyline |=
>> -                                       starts_with_emptyline(recs[ix]->ptr);
>> -
>
> Or would this fix the segfault bug?
> I think we would need to have the check for empty lines
> in both loops to be sure to cover the whole movable range.

Actually we would only need to have the empty line count in the second loop as
the first loop shifted it as much up(backwards) as possible, such that
the hunk sits on one
end of the movable range. The second loop would iterate over the whole
range, so that
would be the only place needed to count.
