From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Thu, 29 May 2014 00:23:53 +0200
Message-ID: <538661F9.50205@alum.mit.edu>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>	<1400174999-26786-42-git-send-email-sahlberg@google.com>	<537F67DD.5010101@alum.mit.edu>	<xmqqzji3f55i.fsf@gitster.dls.corp.google.com>	<5385F0E5.4010306@alum.mit.edu> <xmqqk395et7l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 00:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpmGP-00073U-8l
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 00:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbaE1WX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 18:23:57 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47819 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753426AbaE1WX4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 18:23:56 -0400
X-AuditID: 1207440e-f79026d000000c25-83-538661fbe32b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BB.AC.03109.BF166835; Wed, 28 May 2014 18:23:56 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97A4D.dip0.t-ipconnect.de [79.201.122.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4SMNrjx001763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 28 May 2014 18:23:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqqk395et7l.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqPsnsS3YoHEio0XXlW4mi4beK8wW
	b28uYbT4N6HGgcVj56y77B4LNpV6XLyk7PF5k1wASxS3TVJiSVlwZnqevl0Cd0bPoia2gsWa
	FduWNTE3MLYrdDFyckgImEh0Tm1khrDFJC7cW8/WxcjFISRwmVHi8PvLTBDOeSaJxf2r2UCq
	eAU0Jb5sfANkc3CwCKhKfH0cAxJmE9CVWNTTzAQSFhUIkvhzVhGiWlDi5MwnLCC2iICaxMS2
	Q2A2s0CuROfnDewgtrBAnkTnhy6ovbOYJC50Twc7iFPAWuLY5d1gqyQExCV6GoMgenUk3vU9
	YIaw5SW2v53DPIFRcBaSdbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5m
	iV5qSukmRkiA8+1gbF8vc4hRgINRiYdXQrYtWIg1say4MvcQoyQHk5Io76w4oBBfUn5KZUZi
	cUZ8UWlOavEhRgkOZiURXo1woBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxW
	g4ND4MrBI7MZpVjy8vNSlSR4nYARLiRYlJqeWpGWmVOCUMrEwQmyiEtKpDg1LyW1KLG0JCMe
	FNfxxcDIBknxAN3AB9LOW1yQmAsUhWg9xagoJc4rDpIQAElklObBjYWls1eM4kAfC/P6glTx
	AFMhXPcroMFMQIOfdLaCDC5JREhJNTDacLOuZ/mR9fLIhWq3VzONTNcWqlayms0R3KTwIqqL
	J8ylUPyW1Fy+R0EKattZb5YJv4pvdbZq2rz2y/Hiq3t/TJ58RUB9Kbuz3NXbP+e6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250340>

On 05/28/2014 06:58 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I think for any two backends that are stacked, you would need to break
>> down a transaction as follows (here generalized to include not only
>> deletions):
>>
>>     packed->begin_transaction()
>>     loose->begin_transaction()
>>
>>     # And this part is done within stacked->commit_transaction():
>>     for entry in many_ref_updates():
>>         if have_old:
>>             stacked->verify_reference(ref, old_sha1)
>>
>>         if entry is a delete:
>>             packed->delete_reference(entry)
>>         loose->update_reference(entry)
>>
>>     if (!packed->commit_transaction())
>>         loose->commit_transaction()
> 
> Ugggly.

The ugliness would be encapsulated in the stacked reference backend.  It
wouldn't have to appear in client code.

> In general you would need to worry about the case where the
> first commit succeeds and then the second commit fails, wouldn't
> you?
> 
> The above happens not to break horribly wrong for the "Loose on top
> of Packed" layering, in that the refs you wanted to delete are only
> gone from Packed but still are in Loose, and the end result would be
> some of them are really gone (because they weren't in Loose) and
> some others remain (because they were in Loose), and at least you
> did not lose any ref you did not want to discard.  But it still is
> not what should happen in a proper "transaction".

True, but we don't have proper transactions anyway.  If anything goes
wrong when renaming one of the loose reference lockfiles, we have no way
of reliably rolling back the loose references that have already been
changed.  The word "transaction" as we use it really only suggests that
we are doing our best to change the references all-or-nothing even in
the face of concurrent modifications by other processes.  It certainly
doesn't protect against power failures and stuff like that.

I suppose if you wanted to make reference deletions a little bit more
transaction-like, you could split them into two steps to "loosen" any
packed references and a deletion step that deletes the loose references.
 The advantage of this scheme is that each step requires a transaction
on only a single back end at a time, though it requires part or all of
the other back end to be locked simultaneously.

    # The first two iterations "loosen" any packed references
    # corresponding to references that are to be deleted.  It is purely
    # an internal reorganization that doesn't change the externally-
    # visible values of any references and can be done within a
    # separate transaction:
    for each reference to delete:
        if reference exists packed but not loose:
            create a loose ref with the value from the packed ref
    for each reference to delete:
        if reference exists packed:
            delete packed version of reference

    # Now we only have to delete the loose version of the references.
    # This should be done after activating the packed reference file
    # but while continuing to hold the packed-refs lock:
    for each reference to delete:
        delete loose version of reference

I'd have to think more about whether this all really works generically
without requiring lots of extra round-trips to a possibly-remote
backend.  But I'm not sure we really need this composability in its full
generality.  For example, maybe it is impossible to stack a low-latency
and a high-latency backend together while minimizing round-trips to the
latter.

>>> But the above would not quite work, as somebody needs to remove logs
>>> for refs that were only in the Packed backend, and "repack without
>>> these refs" API supported by the Packed backend cannot be that
>>> somebody---"repack packed-refs without A B C" cannot unconditionally
>>> remove logs for A B C without checking if A B C exists as Loose.
>>
>> Correct.  That's another reason that logging has to be the
>> responsibility of something at the "stacked" level of abstraction or higher.
>>
>> I think the logging should be done by yet another outer layer of
>> wrapper that only does the logging, while also passing all updates
>> down 1:1 to the backend that it wraps (which in our case would be
>> a stacked backend). ... Then the loose and packed backends could
>> remain completely ignorant of the fact that reference updates can
>> be logged.
> 
> That would mean that Loose (or Packed) class cannot be used as-is
> and always needs to be wrapped with the layer that does the logging,
> no?

Correct.

> In a system with "only packed-refs, no loose", you would want
> Packed.deleteRefs() to remove the named refs ref and their reflogs,
> but that would mean that the Layered wrapper that uses Loose
> overlayed on Packed cannot call that method, because it does not
> want reflogs of the refs in Packed covered by the ones in Loose.

The two scenarios would be roughly

    refhandler = new LoggingWrapper(new PackedRefs())

and

    refhandler = new LoggingWrapper(
        new StackedRefs(new LooseRefs(), new PackedRefs())
        )

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
