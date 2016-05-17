From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Tue, 17 May 2016 10:45:31 -0700
Message-ID: <CAGZ79kYbUTC7m-5kdTbvxmSkq__5BVz5x1UeieHhB4TVSqssHw@mail.gmail.com>
References: <20160517031353.23707-1-sbeller@google.com> <20160517031353.23707-5-sbeller@google.com>
 <xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com> <CAGZ79kbYB_4KO+XpYa0OhAcU63Q2M2kLWa03HcxeYS1HJOgfZw@mail.gmail.com>
 <xmqq37pgy4fn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:45:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2j3q-0004iq-L7
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbcEQRpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:45:34 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33789 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbcEQRpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:45:33 -0400
Received: by mail-io0-f171.google.com with SMTP id f89so33269576ioi.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hEXjA4dLqeTTCidJMqZvrfkgZWy3j1DIFM5ep0HAxdA=;
        b=Kgni5PkJ1jrq5WNPGEYy3HrNN8qsupJSkzpSNmrV3lewTlb2SoMpggL5zqWEXa9nuD
         Ct68XCeM1MdgkaUMGEsDHqUBwS4wRLMgNIDbY5pLfYt61cBrLULKBEn/nFen0sbv63kw
         pLQMyTfHUW6zi+sIOXDOCy/DG+xNjDC7tMVdUJGmFLRBYXjjdkWZqORHsE80ESkrdMcg
         I5qwkxwE9gGhOnLzncU22w4ZHK/6o050FN5Lztdpbszgwgly+vreouVPgUBXQL91Ao6i
         bdpFgDYU/EKPnRqFPepSNrQwuqOfCAcwCHhtoMOVaL5SKEACInMwrVEFiAx14GGkufVD
         ZukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hEXjA4dLqeTTCidJMqZvrfkgZWy3j1DIFM5ep0HAxdA=;
        b=jQDog8HAWNgCtDyv6+U1/g2TXXb99GOKTg5QoCZrWDu4RMsN9Qu4gTlxluodRxrlLx
         JYFEX9r1w/cfoeqDPRaDGhKljzYaqi827VpQqnnlldIo+6gI38OiTTQaE+FYbuSkVxf/
         hzqGkbwpHsPxRYPgR16Y0l9qU2DqA0VcazmGn1Cqly00+Qkral7NFLwCN6fNjFquiWr0
         VPblzi52WBRVbyaT+LI61LcGrBgPvsXUcd209sozd0cN2xGnJeqcDNosb6kL81mRr1hI
         3q/eZB7ET/7BF2r+I3+nUq0GdpCNW3YpcdJPQ/tXwFWAiWNMcBJl91lwPCrKBzeU4l3j
         Wm/Q==
X-Gm-Message-State: AOPr4FWkrRDYITQLTi/EzqQInH0Er1gBQU0Cqcx9EpCl6QkEPLv/9xzViY97Fe+E0jJLELaOmOnvz/ak4tOwWfno
X-Received: by 10.36.253.9 with SMTP id m9mr2067799ith.52.1463507132199; Tue,
 17 May 2016 10:45:32 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 17 May 2016 10:45:31 -0700 (PDT)
In-Reply-To: <xmqq37pgy4fn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294884>

On Tue, May 17, 2016 at 10:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Then while parsing ":(attr:VAR1=VAL1 -VAR2 VAR3...)path/to/dir/",
>>
>> This syntax is not pleasant to parse IMHO as it is not clear if the token
>> after white space (-VAR2 here) is another attribute or the next part of
>> the list of VAR1, ...
>
> Remove the ambiguity by declaring that the list is always whitespace
> separated.  No whitespace in var, no whitespace in val, no quoting.
>
> The set of attributes with values expected to be used in the
> pathspec "attribute match" magic, I do not think there is anything
> that wants such a random arbitrary string.  The value side of an
> attribute with value, e.g. "eol=crlf", "conflict-marker-size=7", is
> designed to be a token that our C code is prepared to parse.

I am not talking about crazy stuff here, but consider our own
.gitattributes file:

    * whitespace=!indent,trail,space
    *.[ch] whitespace=indent,trail,space
    *.sh whitespace=indent,trail,space

Now I want to search for

    "the whitespace attribute that is set to at least trail and space"

We cannot use commas for the specification as they are used in .gitattributes,
because that would make it even harder, so
I would imagine this could be used:

     :(attr:whitespace=space trail)

See the whitespace separates the values, not the next variable.

To add another variable, I would suggest using a ':', such as

     :(attr:whitespace=space trail:text)

might a viable thing.



>
> In other words, if you match the parsing semantics of parse_attr()
> in attr.c, you are OK.  The attribute subsystem will not give users
> anything that is more complex than what that routine is prepared to
> parse, and that is a "whitespace separated list, no whitespace in
> attribute names, no whitespace in values, no quoting".
>
