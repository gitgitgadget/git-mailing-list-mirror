From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/21] convert manual allocations to argv_array
Date: Sat, 20 Feb 2016 03:29:29 -0500
Message-ID: <CAPig+cTACku01im72Cd7LxYopwwFaXtKYXkxi53GMrTRyZpFGQ@mail.gmail.com>
References: <20160219111941.GA31906@sigill.intra.peff.net>
	<20160219112324.GF9319@sigill.intra.peff.net>
	<CAPig+cQsFAd4WEoHP-eoz9HCcVzY2uVcDH+_rvkoNjSe-Fg0oA@mail.gmail.com>
	<20160220081010.GA16722@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:30:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX2vh-0003A2-Gt
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 09:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427257AbcBTI3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 03:29:31 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35393 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423122AbcBTI3a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 03:29:30 -0500
Received: by mail-vk0-f46.google.com with SMTP id e6so93750462vkh.2
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 00:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lG1mFyRdPr3bFWTTKV0jqDOEsVxSyk+ZdClFP6/VokA=;
        b=ffqjrPSX1f/bLfhjWTnvef/DvXp7D8nM+PoMMMMZIqfLZ9CiJsBJqReTOmjyNJhXUb
         UxNj9HKUg7R+XYMMP/D0iIP5QP84AlgeIz1G+DikyWwDwPJBIMtarXtMeP1stabKQEjy
         ESdvuZf9CxT6bXG+QRr30tvCWE0JHnbgkahCamkSYgH0P8RjZYbGSibZouai9tetUplM
         2TFKMPmBkvEFjK8iPao9iBAgSnstGhadYMrj+sTLwelr+2CHk1tw+iQhjGH127m1QcdA
         3NxJnPpskCF41KMw/k89UyTpmD10asOyJEktU/XOWc19s3rQEpUeUS28m5ZPQUl0pe2K
         fc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lG1mFyRdPr3bFWTTKV0jqDOEsVxSyk+ZdClFP6/VokA=;
        b=hP14PiMHUSZd0nCCepy+JUpoX2CgiqJuXX/ox0GIj9AELlGkyI9IrUynLQyx/sHGcS
         JhmLKXSxsNN0jEnVIYSftEq21c20GLdyEV/UPAOT3S0WejDKXe0yK+kR8fh/yeIr3GTP
         z6fqMFJYT+0l6XQPBiutWgb1NLKZLGpsxpN533tGhDU/+ANTYO4VjZk64uJSswMBhE9v
         mYD13UX85/l/yxhKSlk4K/4yNmm4YC1DiGmbjhcLI9WQbA4k/ScpoNp7+8KqZzCxmkI7
         O2DEhM3DoAQtXXHvQafDfLoUxmHooTGkYaqqXMfRe50ZjnNV5NMgstX4c3YrGarw5ji1
         ZHxQ==
X-Gm-Message-State: AG10YORZwhyzpbMJHmtrMZF5OsdNDvQbKjvuCfeh6PQYvo5HmFImmM7jWe4tu9osDR45NsO45j9VuAVneWijjw==
X-Received: by 10.31.182.143 with SMTP id g137mr14528194vkf.45.1455956969309;
 Sat, 20 Feb 2016 00:29:29 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 20 Feb 2016 00:29:29 -0800 (PST)
In-Reply-To: <20160220081010.GA16722@sigill.intra.peff.net>
X-Google-Sender-Auth: n6rsBHdpk4ECuWsBnRSThiqEo9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286769>

On Sat, Feb 20, 2016 at 3:10 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 20, 2016 at 03:07:00AM -0500, Eric Sunshine wrote:
>> > +               /* argv strings are now owned by pathspec */
>> > +               paths.argc = 0;
>> > +               argv_array_clear(&paths);
>>
>> This overly intimate knowledge of the internal implementation of
>> argv_array_clear() is rather ugly.
>
> Yep, I agree. Suggestions?
>
> We can just leak the array of "char *". This function is called only
> once per program invocation, and that's unlikely to change.
>
> I guess we can make an argv_array_detach_strings() function. Or maybe
> even just argv_array_detach() would be less gross, and then this
> function could manually free the array but not the strings themselves.

The latter is what I was thinking, and I agree that
argv_array_detach() would be less gross than
argv_array_detach_strings(), however, it also feels a bit wrong since
this sort of ownership transfer is kind of out of scope for
argv_array.

I wonder if a simple "dup'ing" string_list would be more suitable for
this case. You'd have to append the NULL item manually with
string_list_append_nodup(), and string_list_clear() would then be the
correct way to dispose of the list without intimate knowledge of its
implementation and no need for an API extension.
