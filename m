From: Andreas Ericsson <ae@op5.se>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 11:10:19 +0100
Message-ID: <50B5E30B.5080505@op5.se>
References: <20121127204828.577264065F@snark.thyrsus.com> <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com> <7vzk22lmz9.fsf@alter.siamese.dyndns.org> <20121127230419.GA26080@thyrsus.com> <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com> <20121128001231.GA27971@thyrsus.com> <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com> <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com> <20121128011750.GA23498@sigill.intra.peff.net> <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 11:10:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdebL-0005fb-8q
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 11:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab2K1KK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 05:10:28 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40456 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2K1KKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 05:10:24 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3523005wgb.1
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 02:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Qc6/NEMfLMYZ/B/BX9JOYGW29mAgjLQ/RtI9wuBxjcM=;
        b=pzi2QV8mS5n9tHQLZ2GAkvJE0oIL3j4/Rxaz4JdgRH6+JcGV9eBxYlKbp6tebHqmcy
         uBzVBM0SIAjRSAv8ZzLLDD5weVfro21lBbX/PwLLjA0GZgk1u4vGsL6mdhjkPULXN0dE
         uYIqUBCC0z+cKYgM/tkutiq3l0hrM1L52xGkiRbZRrxZI0azqvMeCvE6zW1XySHWahsd
         8v8Tc1wDILqvc0nBie2WMI44BwMSGnzl9WtFfMengHCPxueGoGtoV0ZYtHfZSJpX83/A
         4bImh53HEXLLAZ5TrpKXJGqaoTzcWrf23xHOftAV4anLfFQ9VqYG3z+C9VRF8OA1CBbi
         bmwQ==
Received: by 10.180.107.197 with SMTP id he5mr21525600wib.1.1354097422722;
        Wed, 28 Nov 2012 02:10:22 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id s12sm6313674wik.11.2012.11.28.02.10.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 02:10:21 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
In-Reply-To: <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmGOufwuCJ4aN0b5F+xaV2B+9zTYLMUBTWiBzcB1GiMvFeq61mpeThUfX4OlR/pBoNDDkQN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210725>

On 11/28/2012 08:29 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> There is room for new headers, and older versions of git will ignore
>> them. You could add a new "committer-timestamp" field that elaborates on
>> the timestamp included on the committer line. Newer versions of git
>> would respect it, and older versions would fall back to using the
>> committer timestamp.
>>
>> But I really wonder if anybody actually cares about adding sub-second
>> timestamp support, or if it is merely "because SVN has it".
> 
> Roundtrip conversions may benefit from sub-second timestamps, but
> personally I think negative timestamps are more interesting and of
> practical use.  Prehistoric projects need them even if they intend
> to switch to Git, never to go back to their original tarballs and
> collection of RCS ,v files.
> 
> And if we were to add "committer-timestamp" and friends to support
> negative timestamps anyway (because older tools will not support
> them), supporting sub-second part might be something we want to
> think about at the same time.
> 
> We would however need to be extra careful.  How should we express
> half-second past Tue Nov 27 23:24:16 2012 (US/Pacific)?  Would we
> spell it 1354087456.5?  1354087456.500?  Would we require decimal
> representation of floating point numbers to be normalized in some
> way (e.g. minimum number of digits without losing precision)?  The
> same timestamp needs to be expressed the same way, or we will end up
> with different commit objects, which defeats the whole purpose of
> introducing subsecond timestamps to support round-trip conversions.
> 
> If we were to use a separate "subsecond" fields, another thing we
> need to be careful about is the order of these extra fields, exactly
> for the same reason.
> 

If we're going to support pre-epoch timestamps, we'll have to do that
for 2.0 anyway, since we'll otherwise have two conflicting dates in
the commit object.

Adding support for parsing them now and start writing them in 2.0
would make sense.

In that case, we'd have to print timestamps as
printf("%lu.%06lu", tv.tv_sec, tv.tv_usec);

I'm unsure how useful it is to support pre-epoch dates though. It's
hard to find software where anyone really cares about the code from
43 years ago with anything but historical interest, and for those
who take the museum road, I'm betting it's more interesting to see
how people worked back then than it is to see what they wrote.

Aside from that, it would be trivial to support museum style history
viewing with a special flag that treats the timestamps as minutes
since 1900-01-01 or some such, giving us plenty of time before even
the first punch-card was invented. It wouldn't be much harder to
let the user specify the timeunit and the start-point either, and
then we could store the history of carbon-based lifeforms on earth
in git.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
