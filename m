From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Tue, 2 Sep 2008 10:48:50 +0300
Message-ID: <94a0d4530809020048n3894131as351d72d2394ea1a7@mail.gmail.com>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
	 <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
	 <20080901223802.GK7482@spearce.org>
	 <94a0d4530809011552h59e476e0q9033f0b917288a8f@mail.gmail.com>
	 <20080902043951.GB13248@spearce.org>
	 <7vfxojrvvp.fsf@gitster.siamese.dyndns.org>
	 <20080902053503.GD13248@spearce.org>
	 <7v8wubm22y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQeD-00054g-RK
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbYIBHsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 03:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbYIBHsv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:48:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:41928 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYIBHsv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:48:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2141368rvb.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1UUZ2J1BKjN7/cc0BSyUBVEJkD/6Lyh9m6Br6WrYhHY=;
        b=cmFKCJhDj3dpPyZU1xQB1Il960x2EvmMQcfxPf1LyokGMhaHN+0+pusknKp0GasUal
         hVh9k6huArTXS+IgP3qa68VWVWfvvpq7pwQvn+cSOvruI47wESsVzu/Ewh0Y/yTgOT34
         kJAaKnr1xW6WVyTTRa4nVMDabYtfO2fRiWBCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=orfAjgBCFWGzKaW/KEkrSq74RAHWku5D2ozDq8zTllpaTTDLkIiEE4QBqTg+E642mE
         FtAoehgZlai8WObbzpaujvzEeb8EV80vgcNNUX+NARVP4n08aa46gSrLAnKCrVIF7c2v
         G6g0EtBT6PI/foAh4psTF5cuXexOEDCdouTSs=
Received: by 10.141.212.5 with SMTP id o5mr3988242rvq.20.1220341730103;
        Tue, 02 Sep 2008 00:48:50 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Tue, 2 Sep 2008 00:48:50 -0700 (PDT)
In-Reply-To: <7v8wubm22y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94663>

On Tue, Sep 2, 2008 at 10:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> I think selective loosening of consistency check makes sense very much,
>>> but I have been wondering if these should be command line options.
>>>
>>> The only example we saw so far is about output from one exporter.  Perhaps
>>> it should be given to fast-import as initial set of commands ("#pragma"!)
>>> that describes the nature of the input file?
>>
>> Yea, I briefly considered that when I added the timestamp format
>> option.  I didn't bother because it was a single option and I figured
>> most frontends start git-fast-import directly.  But with this being
>> added a "format pragrma header thingy" makes a lot of sense.
>
> Oh, I did not mean to suggest hiding it as a comment to silently allow
> older fast-import slurp such input and produce broken results.
>
> For input that needs such loosened error checking, old fast-import won't
> produce correct results _anyway_, so I would agree that making these
> things into explicit commands to cause older fast-import to error out
> would make a lot more sense.

I like the idea. This way all the information to make it work is
already on the stream.

If the importer doesn't have a certain feature it can fail already at
initialization.

-- 
Felipe Contreras
