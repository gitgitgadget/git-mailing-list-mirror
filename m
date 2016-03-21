From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] read-cache: increase write buffer size
Date: Mon, 21 Mar 2016 12:22:45 -0400
Organization: Twitter
Message-ID: <1458577365.9385.31.camel@twopensource.com>
References: <1458350341-12276-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8ABvs822-vtELCm2wvvpxRV6wtEEr5Ge1qxH_zOcqdwSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:22:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai2bV-0003qz-Kz
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 17:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566AbcCUQWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 12:22:49 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34580 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064AbcCUQWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 12:22:49 -0400
Received: by mail-qg0-f48.google.com with SMTP id w104so156154688qge.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=LCl/c3osn8qCj6ovnX+AERLn7pv3jB0tyHRoXcVYyI8=;
        b=UDqJH+sCxs0P/cFvNLlxJ7bdVtbVMdZENxIQ0i1vDAQOYIb/TVvVA39IBAyFN8jrsi
         7NOy7LuE5IfdB3PBJxo3PZhcNywcskoopr4XlgNV4PgkzEC4Z3vSNYMPfX1lBrYgJBIh
         p6E6PufKF0hPMdPI8XYaiu8nuZAXSEKuTzWEHFsa50z/V3yoMdQa9tMOh7LbaSdDjJPo
         lOvcjjEZAlksMD6hMV662ZbRTRm6d/nFQdIKbNi1TS7WNfwlrTQgByH2LHBuFTh1gu1M
         vbuEoeYuswiIc6qan0NRRtLCHW2LmPC1gcSNgatXn0Kc0PIOELZ52yqvakw6K4vwncuy
         5CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=LCl/c3osn8qCj6ovnX+AERLn7pv3jB0tyHRoXcVYyI8=;
        b=BgSwhVxgwmQIkbb9kqx+/gJB2s0W6Ge1Vbs0HzAY5GH3/jBTsdrHepovWx5chnpar4
         bBmwmoSF548BRAmFnLqjASnoeEUk4yeoVbuuYujbxZbjnil7/jMpO15lZ025T0FfqvZV
         X7u4kiS3wu2eYaga6d4pFYwaoB5CZPVOagmEdPtcNZl8C541R96wPbIz89h5IOyN06f0
         HWtDBmXS20BczIiGTFJGD5RTxkbJQwE/g2NiBb4vLkF5a+EV2hrhrjF/Du6z6v37uGjW
         jVK9Ut0lIa9XVGjeayzhi7IcCDMaEIWr2RrMXmD1XYILhbKJic6uFzLH1cABJrrYIrUs
         TgeA==
X-Gm-Message-State: AD7BkJJfsNMpVngaSf9uom8SXYXZaqNjLQ1xfLsALoUH0w0qwuNbg/ibiabNA5mSJaE4Jw==
X-Received: by 10.140.91.106 with SMTP id y97mr41251607qgd.20.1458577367535;
        Mon, 21 Mar 2016 09:22:47 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id s104sm12520978qgs.22.2016.03.21.09.22.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2016 09:22:46 -0700 (PDT)
In-Reply-To: <CACsJy8ABvs822-vtELCm2wvvpxRV6wtEEr5Ge1qxH_zOcqdwSA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289424>

On Sat, 2016-03-19 at 18:18 +0700, Duy Nguyen wrote:
> On Sat, Mar 19, 2016 at 8:19 AM, David Turner <
> dturner@twopensource.com> wrote:
> > Each write() has syscall overhead, and writing a large index
> > entails
> > many such calls.  A larger write buffer reduces the overhead,
> > leading to increased performance.
> > 
> > On my repo, which has an index size of 30m, this saves about 10ms
> > of
> > time writing the index.
> 
> I wonder if split-index does not work as intended. Because if it
> does,
> you should rarely need to write that such big index files (or is this
> 30mb the small part and the base index is even bigger?).
> 
> But I agree with Torsten that we should make this configurable,
> preferably via config file, if not we can still move this define back
> in Makefile, overridable using config.mak

Oh, right, split index.  Yeah, I should just turn that on.  Nevermind.
