From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] for-each-ref: `:short` format for `refname`
Date: Tue, 2 Sep 2008 09:26:27 +0200
Message-ID: <36ca99e90809020026j37c41a8fu99b45abbd02eb372@mail.gmail.com>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org>
	 <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080901131523.GA6739@neumann>
	 <36ca99e90809010713h7c673d10j6addd1624a655371@mail.gmail.com>
	 <36ca99e90809011052s568fa6e4y89e56769f63806c1@mail.gmail.com>
	 <20080901191051.GD7482@spearce.org>
	 <36ca99e90809011410w646cc6eajb3063ea3501f173c@mail.gmail.com>
	 <7v7i9vv9n2.fsf@gitster.siamese.dyndns.org>
	 <36ca99e90809011444v3fca09c4o4d9dcf1a7249a00a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"=?UTF-8?Q?SZEDER_G=C3=A1bor?=" <szeder@ira.uka.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:27:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQIZ-000722-6C
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbYIBH03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 03:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbYIBH03
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:26:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:59619 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYIBH02 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:26:28 -0400
Received: by wx-out-0506.google.com with SMTP id h29so643382wxd.4
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JimUENyUSd6cP/QKclQvyFEvDLjtEz89HGN/GPbakg0=;
        b=KfcqeF6QO3g+A3He6REC7XCTbq1NzacWWbOYGcLUKeapPhVeoKUqX9FsKTy7c+k2eG
         fZErjf6wdtAcC9+oxnjgY6faYjt4fPs3K5rSD+2aYQFtWbeOdsmzKVbxisE3ljnL7W4y
         ztB14Zr6l2iAxdQxfLH5LaVUGGEvVegWOSEIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vUkUU7nxh9Vcu+LFO1AeomDY2GcUcc0KqFnz8uDTo0yR9ETv8ktt+SbK3Hn3W/B+Yw
         j968L1XR7pXKPLEx6SCx2IeZ66Pa49TE3teW+P0PHizDRVZ4X3lrG6bmCrfcpjXgo/Nj
         5vMFYMUN/LteSawbsaIKUaPdzWohJtJzOBZFQ=
Received: by 10.70.48.13 with SMTP id v13mr9149177wxv.28.1220340387250;
        Tue, 02 Sep 2008 00:26:27 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Tue, 2 Sep 2008 00:26:27 -0700 (PDT)
In-Reply-To: <36ca99e90809011444v3fca09c4o4d9dcf1a7249a00a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94659>

On Mon, Sep 1, 2008 at 23:44, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> On Mon, Sep 1, 2008 at 23:28, Junio C Hamano <gitster@pobox.com> wrote:
>> "Bert Wesarg" <bert.wesarg@googlemail.com> writes:
>>
>>> On Mon, Sep 1, 2008 at 21:10, Shawn O. Pearce <spearce@spearce.org> wrote:
>>> ...
>>>> You can still get ambiguous names.  Avoiding them requires going
>>>> through all refs and building their short forms, then using the
>>>> full ref name for any ref which had more than one name shorten to
>>>> the same string.  Ugly, but implementable, and probably something
>>>> that should be considered.
>>>
>>> What about: try the list backwards until the first match, than try the
>>> matched part (this what %.*s matched) with the forward list, if both
>>> give the same pattern, its not disambiguous. If not try the next
>>> pattern backwards.
>>
>> How does it catch the case where you have both 'xyzzy' branch and 'xyzzy'
>> tag, which is the point of disambiguation issue Shawn raised?
> Right.
I was wrong:

given these two refs:

  refs/heads/xyzzy
  refs/tags/xyzzy

first try to shorten "refs/heads/xyzzy":

  first (from the end) matched pattern is "refs/heads/%.*s" with
"xyzzy" as result

  but resolved ref for "xyzzy" is "refs/tags/xyzzy" => continue

  next matched pattern is "%.*s" with "refs/heads/xyzzy" as result

  end result is therefore: "refs/heads/xyzzy"

second try to shorten "refs/tags/xyzzy":

  first (from the end) matched pattern is "refs/tags/%.*s" with
"xyzzy" as result

  resolved ref for "xyzzy" is "refs/tags/xyzzy" => end

  end result is therefore: "xyzzy"

the output would be:

  refs/heads/xyzzy
  xyzzy

The question is now, if this is usable for bash completion? Current
bash completion would handle this case wrong, because you get two
xyzzy.

Bert
