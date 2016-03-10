From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 01/19] trace.c: add GIT_TRACE_PACK_STATS for pack usage
 statistics
Date: Wed, 09 Mar 2016 19:05:42 -0500
Organization: Twitter
Message-ID: <1457568342.13557.11.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-2-git-send-email-dturner@twopensource.com>
	 <xmqq4mcfgsxn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:05:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ado6w-0004ih-Op
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 01:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbcCJAFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 19:05:47 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35984 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbcCJAFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 19:05:45 -0500
Received: by mail-qk0-f175.google.com with SMTP id s68so27815030qkh.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 16:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=vqu2Gg9EplijU/xfiHSZyhTj8leXJtrsO1nsVONDMX4=;
        b=LdNzl4e7TpJHz8JVKhPmpEF0oqMxw93y1PNHQ8gq5wEG9ONpvPUjrMY3z74mJjEkoX
         lQ6UnlinBOUE6daNYh6KbaQUcwq6iIRUO9763ZJDi1N9camLnvj/xG4XQMwXUI9vWHSA
         FjMpiwyl3xn79F4CEJ9EBs0h1gMzPpcEd6Le+1EO5+wv6C3V5NTUor+CrIwB0rHAbJPS
         BLOIxsQS1IxNljoH8b8mJvkoNc33ktPfFwA54HA2a6RDeyTqNitLu4dvfxIBtv5kv8TZ
         MObOOUTfvQBT4WDWtSVjDeoiO1hokLg2IbyPhnq07ftauxON8XPuw6f82gZ/7uOKMkxd
         zlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vqu2Gg9EplijU/xfiHSZyhTj8leXJtrsO1nsVONDMX4=;
        b=JCBrelTs6D+6POBNYaoZ2c0tQUEw1LZVLz7yHrBr3PO7MTbykmFp/9AeY1mOlE08fn
         y3hy8cQSpQI/wExWVj6cfzBN8Wgpmt1mdxfKVRLQ2BMjMxC5TSzbDodbBgeu1BrtEH91
         /DpYgRNymXP6QmyU0qBRFPagixbwCjSYKsIBfF6jc+DWoAl0VgsBu07EmDLHp4SGJMFK
         H28QiJq37vtt+RWtGURX+/DEvfuPZX9VvNbDRiJ6kd4/qwXfsxcljyrDaOP3xcUj5c/V
         JzjPxy/Iniycn2GdSQLX/tvFAisUiZQW4v2cwyRxGRRuKNE9oyMb/eZ02avkGgHGomzp
         1qEw==
X-Gm-Message-State: AD7BkJIqIemRGUylY9i36PuuDRggiA3opQW8i7wjLZO/FnczumqzijFZQwTiU4ec4yxeTA==
X-Received: by 10.55.55.138 with SMTP id e132mr576804qka.11.1457568344296;
        Wed, 09 Mar 2016 16:05:44 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id m5sm546320qki.15.2016.03.09.16.05.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 16:05:43 -0800 (PST)
In-Reply-To: <xmqq4mcfgsxn.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288586>

On Wed, 2016-03-09 at 14:58 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
...
> > trace_stats() is intended for GIT_TRACE_*_STATS variable group and
> > GIT_TRACE_PACK_STATS is more like an example how new vars can be
> > added.
...

> > +	pack_access_nr++;
> >  }
> 
> This looks rather half-hearted, in that those who are interested in
> this new number can run "wc -l" on the pack-access trace log without
> adding a new "stats" anyway.  It may make the "stats" far more
> useful to keep track of the summary information of what would be
> written to the pack access log and add to the report_pack_stats()
> output things like the average and median distance of seeks
> (i.e. differences in the "obj_offset" into the same pack by two
> adjacent pack accesse) and the variance, for example?

On reflection, I do not think I need this patch; it was in Duy's series
and the index stats patch would need to be rewritten slightly to get
rid of it, but I'm OK with that.  I wanted to make minimal changes to
Duy's patches, but I'd rather make larger changes than do work on
patches I don't need.

So unless Duy objects, I'm going to drop this from the series.
