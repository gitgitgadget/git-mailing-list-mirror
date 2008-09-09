From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v4] for-each-ref: `:short` format for `refname`
Date: Tue, 9 Sep 2008 10:57:42 +0200
Message-ID: <36ca99e90809090157m64253b89p6adf6a49b6d62e99@mail.gmail.com>
References: <7vtzcxaxgr.fsf@gitster.siamese.dyndns.org>
	 <1220649383-17916-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vfxoadz5c.fsf@gitster.siamese.dyndns.org>
	 <36ca99e90809082352q3c87447eme73379673fe652f4@mail.gmail.com>
	 <7vod2xagmr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 10:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcz3k-0004rw-La
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbYIII5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbYIII5o
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:57:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:19712 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbYIII5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:57:43 -0400
Received: by wx-out-0506.google.com with SMTP id h27so473701wxd.4
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Z/Qj8GByeRpLiotJALGoZykfxRwRyPj5EPO0OzRhxUs=;
        b=GzLlf/5NhPUVNjVLYc4pUSzuxfKHxnQEqZGpGzZWT/ltrhRDGjp+qSQ6ftiFOai+Tb
         ti0PSYSCt/emnV682vuq7AHbVUYo2CRnFYpOAn+Toca2MWYzZxQUNuKB5Xtio9ltZZ08
         MpVYbw196M8XtHfzOSxXPc3ZJMGkzOiO8Cuo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Y8oJFG6TUvPIKLoPtJSEJidWF4GOi+wgqfYeVsq0rirWZjWhHou7T0V/NrYAriEGa9
         upPjlCn8EgJ7Kmxp+oIYT6laoAryheRY8x/uSAjHazw7XRNG2H32PauudTIpNNQkXuWp
         gHBy6qNRqPgImNzWITxoJ4gebLs0ooHCUHFfM=
Received: by 10.70.80.6 with SMTP id d6mr20417117wxb.53.1220950662120;
        Tue, 09 Sep 2008 01:57:42 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Tue, 9 Sep 2008 01:57:41 -0700 (PDT)
In-Reply-To: <7vod2xagmr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95361>

On Tue, Sep 9, 2008 at 10:05, Junio C Hamano <gitster@pobox.com> wrote:
> "Bert Wesarg" <bert.wesarg@googlemail.com> writes:
>
>> Any opinions, whether we want the 'strict' mode? i.e.:
>>
>> for refs/heads/xyzzy and refs/tags/xyzzy:
>>
>> loose mode (current implementation):
>>
>>   refs/heads/xyzzy => heads/xyzzy
>>   refs/tags/xyzzy  => xyzzy
>>
>> there would be a ambiguous warning (if enabled) if you use xyzzy as a
>> tag, but it resolves correctly to the tag.
>>
>> strict mode:
>>
>>   refs/heads/xyzzy => heads/xyzzy
>>   refs/tags/xyzzy  => tags/xyzzy
>>
>> will always produce a non-ambiguous short forms.
>
> I have no strong opinions either way, but if we want to pick only one, I
> suspect that the loose mode would be more appropriate for bash completion
> purposes exactly because:
>
>  (1) the shorter form would match the users' expectations, and;
>
>  (2) if it triggers ambiguity warning to use that result that matches
>     users' expectations, it is a *good thing* --- it reminds the user
>     that s/he is playing with fire _if_ the user is of careful type who
>     enables the ambiguity warning.
>
> Thinking about it from a different angle, it would make more sense to use
> loose mode if the user does not have ambiguity warning configured, and use
> strict mode if the warning is enabled.  Then people who will get warnings
> from ambiguity will not get an ambiguous completion, and people who won't
> will get shorter but still unambiguous completion.
>
> Which means, despite what I said earlier, now I have a mild preference to
> tie the choice to core.wawrnambigousrefs configuration.
A really nice idea.  Await PATCH v5.  I had to change my plans for
today, unfortunately.

Bert
>
