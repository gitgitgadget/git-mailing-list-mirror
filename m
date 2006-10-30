X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 09:05:04 +0100
Message-ID: <200610300905.04454.jnareb@gmail.com>
References: <92622.251.qm@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 08:05:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kI8LY+sHIQd2XqiFa8faxHCu1aBg6ZThCse9O46rk/trR+3zRtEuHO4ob3W3FumoqbhjNmP+rd7lF1y449DDkyBA4PkzfVmCYSvSkZEuMVkpxcONofLlLZnCRA+WTIjpxqbSjj15GsYVdIwigXalhZsOKJ9P3upELtBjlIxNYyY=
User-Agent: KMail/1.9.3
In-Reply-To: <92622.251.qm@web31812.mail.mud.yahoo.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30485>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeS8w-0004k7-9M for gcvg-git@gmane.org; Mon, 30 Oct
 2006 09:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161166AbWJ3IFF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 03:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWJ3IFF
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 03:05:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:8682 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932435AbWJ3IFD
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 03:05:03 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1068278ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 00:05:02 -0800 (PST)
Received: by 10.66.244.11 with SMTP id r11mr3706652ugh; Mon, 30 Oct 2006
 00:05:01 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 29sm2576009uga.2006.10.30.00.05.01; Mon, 30 Oct
 2006 00:05:01 -0800 (PST)
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> Replace "gitweb diff header" with its full sha1 of blobs and replace
>> it by "git diff" header and extended diff header. Change also somewhat
>> highlighting of diffs.
>> 
>> Changes:
>> * "gitweb diff header" which looked for example like below:
>>     file:_<sha1 before>_ -> file:_<sha1 after>_
>>   where 'file' is file type and '<sha1>' is full sha1 of blob is
>>   changed to
>>     diff --git _a/<file before>_ _b/<file after>_
>>   In both cases links are visible and use default link style. If file
>>   is added, a/<file> is not hyperlinked, if file is deleted, b/<file>
>>   is not hyperlinked.
> 
> "Everything clickable underlined" isn't the best way to represent things.
> Anyway, my 2 cents is that I don't like the overly explicit underlineing.
> I liked it the way it was in take 1.

Thet is the only "obviously link" per patch. And I think there should be
at least one non-hidden link.

BTW. comments like this are the reason I've sent the patch as-is, without
resolving the strange filenames problem (it would be nice if somebody was
to send code; well Junio send patch to address core git filename quoting
issue).

>> * there is added "extended diff header", with <path> and <hash>
>>   hyperlinked (and <hash> shortened to 7 characters), and <mode>
>>   explained: '<mode>' is extended to '<mode> (<file type>)'.
>> * <file> hyperlinking should work also when <file> is originally
>>   quoted. For now we present filename quoted. This needed changes to
>>   parse_difftree_raw_line subroutine. And doesn't work: perhaps
>>   unquote is broken.
> 
> In which case we shouldn't commit this.  IOW, let's commit things
> which we _know_ to work.
> 
> Why not resubmit your original patch with the bugfixes as few comments
> as mentioned?

I'll do that, but for now quoting/unquoting filename is broken, both
in gitweb but also to lesser extent in git core (quoting perfectly valid
UTF-8 characters).

I'll try to adress that, but I wanted to send next RFC patch for review.

>> * from-file/to-file two-line header lines have slightly darker color
>>   than removed/added lines.
>> * chunk header has now delicate line above for easier finding chunk
>>   boundary, and top margin of 1px.
> 
> Wouldn't this be confusing with the other fine lines?
> I personally don't like this chunk separation.  Chunk separation
> already exists as is and we view it all the time elsewhere.

But not always the program displaying diff can display such line
separating chunks, for example on text terminal it can't.

But if you think that the dotted 1px #ffbbff line is too intrusive,
we can remove it (and perhaps increase vertical space a few pixels).
I'd like to have more opinions first.

BTW. you can easily override it in your CSS file.
 
> If you'd like to separate chunks, why not darken the background
> of the section of line the chunk header is printed at?  I.e.
> anything between the @@ including the @@.

I'd rather have this one in a separate commit (this needs changes
to format_diff_line, not only to git_patchset_body).

-- 
Jakub Narebski
