From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 5/9] patch-id: document new behaviour
Date: Sun, 27 Apr 2014 21:26:23 +0300
Message-ID: <20140427182623.GA28551@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
 <1398331809-11309-5-git-send-email-mst@redhat.com>
 <20140424173325.GK15516@google.com>
 <20140424212639.GA9129@redhat.com>
 <xmqqzjjatm0x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 20:25:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTlx-0000lq-OL
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 20:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbaD0SZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 14:25:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1205 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbaD0SZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 14:25:48 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3RIPaXn004869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Apr 2014 14:25:36 -0400
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3RIPX7w002629;
	Sun, 27 Apr 2014 14:25:34 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjjatm0x.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247218>

On Thu, Apr 24, 2014 at 03:12:14PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> >> > +--unstable::
> >> > +	Use a non-symmetrical sum of hashes, such that reordering
> >> 
> >> What is a non-symmetrical sum?
> >
> > Non-symmetrical combination function is better?
> 
> I do not think either is very good X-<.
> 
> The primary points to convey for "--stable" are:
> 
>  - Two patches produced by comparing the same two trees with two
>    different settings for "-O<orderfile>" will result in the same
>    patchc signature, thereby allowing the computed result to be used
>    as a key to index some metainformation about the change between
>    the two trees;
> 
>  - It will produce a result different from the plain vanilla
>    patch-id has always produced even when used on a diff output
>    taken without any use of "-O<orderfile>", thereby making existing
>    databases keyed by patch-ids unusable.
> 
> The fact that we happened to use a patch-id that catches that
> somebody reordered the same patch into different file order and
> declares that they are two different changes is a more historical
> accident than a designed goal.
> 
> I would even say that we would have used the "stable" version from
> the beginning if we thought that "-O<orderfile>" would be widely
> used when these two features both appeared.  Even though I was the
> guilty one who introduced it, I'd admit that "-O<orderfile>" has
> merely been a curiosity from its inception and has been a failed
> experiment, not in the sense that the feature does not work as
> adverertised (it does), but in the sense that it is not widely used
> (evidenced by the lack of complaints on missing diff.orderfile for a
> long time) at all.  With "-O<orderfile>" being a failed experiment,
> the "unstability" did not matter, so it has stuck.
> 
> The only two things worth mentioning about "--unstable", if our
> future direction is to see diff.orderfile and "--stable" a lot more
> widely used, are:
> 
>  (1) it keeps producing the same patch-id as existing versions of
>      Git, so users with existing databases (who do not deal with
>      reordered patches) may want to use it; and perhaps
> 
>  (2) it will not consider a patch taken with "-O<orderfile>" and
>      another without it from the same source the same patches.
> 
> Mathmatically speaking, mentioning "non-symmetrial" might be one way
> of expressing the latter point (2), but stressing on that alone
> without mentioning (1) misses the point.  (2) is _not_ a designed
> feature, so it is not very interesting.  Unless you have an existing
> database, there is no reason to use "--unstable".
> 
> On the other hand (1) is a very relevant thing to mention, as we are
> talking about a feature that, if unused, may break existing users'
> data.

OK I did just that, pls take a look.
