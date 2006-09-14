From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [Monotone-devel] cvs import
Date: Wed, 13 Sep 2006 20:57:33 -0400
Message-ID: <9e4733910609131757l7ce4b637oae18b523b1b7f0a4@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	 <20060913225200.GA10186@frances.vorpus.org>
	 <1158190921.29313.175.camel@neko.keithp.com>
	 <20060914003242.GA19228@frances.vorpus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: dev-return-1631-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 02:57:36 2006
Return-path: <dev-return-1631-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNfXs-0002aB-F3
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 02:57:36 +0200
Received: (qmail 32712 invoked by uid 5000); 14 Sep 2006 00:57:34 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 32702 invoked from network); 14 Sep 2006 00:57:34 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAB1FCEWLJUYCAgcECAkGHQ
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="26757946:sNHT16710106"
X-IRONPORT: SCANNED
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DTb7PK+q4TKdJIdAVo7y9IEHhvtSqh4TcgKTfLraps9sP32ScPh+j73XHx6fVflienLSJcaR/P7RHowpazN/X8By8TNx9hXS/JxLdBK5dP57PczGYpfh/3cbmvZaipdKutKaflOv8j2DCgIyYj9E3XmKU8hGoFTI/CtEI7tnJuA=
To: "Keith Packard" <keithp@keithp.com>, dev@cvs2svn.tigris.org, 
	monotone-devel@nongnu.org, "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <20060914003242.GA19228@frances.vorpus.org>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26967>

On 9/13/06, Nathaniel Smith <njs@pobox.com> wrote:
> On Wed, Sep 13, 2006 at 04:42:01PM -0700, Keith Packard wrote:
> > However, this means that parsecvs must hold the entire tree state in
> > memory, which turned out to be its downfall with large repositories.
> > Worked great for all of X.org, not so good with Mozilla.
>
> Does anyone know how big Mozilla (or other humonguous repos, like KDE)
> are, in terms of number of files?

Mozilla is 120,000 files. The complexity comes from 10 years worth of
history. A few of the files have around 1,700 revisions. There are
about 1,600 branches and 1,000 tags. The branch number is inflated
because cvs2svn is generating extra branches, the real number is
around 700. The CVS repo takes 4.2GB disk space. cvs2svn turns this
into 250,000 commits over about 1M unique revisions.

>
> A few numbers for repositories I had lying around:
>   Linux kernel -- ~21,000
>   gcc -- ~42,000
>   NetBSD "src" repo -- ~100,000
>   uClinux distro -- ~110,000
>
> These don't seem very indimidating... even if it takes an entire
> kilobyte per CVS revision to store the information about it that we
> need to make decisions about how to move the frontier... that's only
> 110 megabytes for the largest of these repos.  The frontier sweeping
> algorithm only _needs_ to have available the current frontier, and the
> current frontier+1.  Storing information on every version of every
> file in memory might be worse; but since the algorithm accesses this
> data in a linear way, it'd be easy enough to stick those in a
> lookaside table on disk if really necessary, like a bdb or sqlite file
> or something.
>
> (Again, in practice storing all the metadata for the entire 180k
> revisions of the 100k files in the netbsd repo was possible on a
> desktop.  Monotone's cvs_import does try somewhat to be frugal about
> memory, though, interning strings and suchlike.)
>
> -- Nathaniel
>
> --
> When the flush of a new-born sun fell first on Eden's green and gold,
> Our father Adam sat under the Tree and scratched with a stick in the mould;
> And the first rude sketch that the world had seen was joy to his mighty heart,
> Till the Devil whispered behind the leaves, "It's pretty, but is it Art?"
>   -- The Conundrum of the Workshops, Rudyard Kipling
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
